require 'json'
require 'open-uri'

class PodcastsController < ApplicationController
  def index
    @podcasts = Podcast.all
    if params[:query].present?

      @podcasts = HTTParty.get "https://listennotes.p.mashape.com/api/v1/search?type=podcast&q=#{params[:query]}",
      headers:{
        "X-Mashape-Key" => "xpFi4BobqYmshRgxPvEXythBH7XAp1et0DjjsntjmRrxXROJri",
        "Accept" => "application/json"
      }

      @episodes = HTTParty.get "https://listennotes.p.mashape.com/api/v1/search?type=episode&q=#{params[:query]}",
      headers:{
        "X-Mashape-Key" => "xpFi4BobqYmshRgxPvEXythBH7XAp1et0DjjsntjmRrxXROJri",
        "Accept" => "application/json"
      }

      @podcasts["results"].each do |podcast_info|
        podcast = Podcast.find_or_initialize_by(itunes_id: podcast_info['itunes_id'])
        next if podcast.persisted?

        response = HTTParty.get(
          "https://listennotes.p.mashape.com/api/v1/podcasts/#{podcast['id']}?next_episode_pub_date=1479154463000&sort=recent_first",
          headers: {
            "X-Mashape-Key" => "Q0II77SpNGmshDjZ1UEWgoWhXgTdp1KOsTsjsnI2eZEFcMYwu3",
            "Accept" => "application/json"
          }
        )

        podcast.update(
          total_episodes: response["total_episodes"],
          itunes_id: response["itunes_id"],
          image: response["image"],
          title: response["title_original"],
          episodes: response["episodes"],
          country: response["country"],
          description: response["description"],
          language: response["language"],
          korean_id: response["id"],
          lastest_pub_date_ms: response["lastest_pub_date_ms"],
          earliest_pub_date_ms: response["earliest_pub_date_ms"],
          publisher: response["publisher"],
          genres: response["genres"],
          extra: response["extra"]
        )
      end
      # @episodes = HTTParty.get "https://listennotes.p.mashape.com/api/v1/search?type=episode&q=#{params[:query]}",
      # headers:{
      #   "X-Mashape-Key" => "xpFi4BobqYmshRgxPvEXythBH7XAp1et0DjjsntjmRrxXROJri",
      #   "Accept" => "application/json"
      # }
      # @episodes["results"].each do |episode|

      #   response = Unirest.get "https://listennotes.p.mashape.com/api/v1/episodes/#{episode['podcast_id']}?next_episode_pub_date=1479154463000&sort=recent_first",
      #     headers:{
      #       "X-Mashape-Key" => "Q0II77SpNGmshDjZ1UEWgoWhXgTdp1KOsTsjsnI2eZEFcMYwu3",
      #       "Accept" => "application/json"
      #     }

      #   Episode.create!(audio: episode["audio"],
      #     korean_podcast_id: episode["podcast_id"],
      #     itunes_id:episode["itunes_id"],
      #     audio_length:episode["audio_length"],
      #     description_original:episode["description_original"],
      #     image: episode["image"],
      #     genres: episode["genres"],
      #     publisher_original: episode["publisher_original"],
      #     title_original: episode["title_original"],
      #     pub_date_ms: episode["pub_date_ms"],
      #     podcast_title_original: episode["podcast_title_original"]
      #     )
      # end

      PgSearch::Multisearch.rebuild(Podcast)
      PgSearch::Multisearch.rebuild(Episode)
      @results = PgSearch.multisearch(params[:query])
    else
      @podcasts = Podcast.all
    end
  end

  def show
    @podcast = Podcast.find(params[:id])
  end

  def show_by_id
    if params[:id].present?

      url = "https://itunes.apple.com/search?term=#{params[:id]}"
      podcast_serialized = open(url).read
      @podcast_id = JSON.parse(podcast_serialized)

      url = "https://itunes.apple.com/search?term=#{params[:id]}"
      episodes_serialized = open(url).read
      @episode = JSON.parse(episodes_serialized)
    else
      @podcast = Podcast.find(params[:id])
    end
  end
  # def index_subscription
  #   @podcasts = User.podcasts
  # end

  # def add_new_comment
  #   @podcast = Podcast.find(params[:id])
  #   @podcast.comments << Podcast.new(params[:comment])
  #   # redirect_to :action => :show, :id => @podcast
  #   redirect_to podcast_path(@podcast)
  # end

  def upvote
    @podcast = Podcast.find(params[:id])
    @podcast.upvote_from current_user
    if request.env['PATH_INFO'] == "/"
      redirect_to root_path
    else
      redirect_to podcast_path(@podcast)
    end
  end

  def downvote
    @podcast = Podcast.find(params[:id])
    @podcast.downvote_from current_user
    if request.env['PATH_INFO'] == "/"
      redirect_to root_path
    else
      redirect_to podcast_path(@podcast)
    end
  end

  def follow
    @podcast = Podcast.find(params[:id])
    current_user.follow(@podcast)
    @follow = Follow.find_by(follower: @current_user, followable: @podcast)
    respond_to :js
    respond_to do |format|
    format.js {render inline: "location.reload();" }
    end
  end

  def unfollow
    @podcast = Podcast.find(params[:id])
    current_user.stop_following(@podcast)
    respond_to :js
    respond_to do |format|
    format.js {render inline: "location.reload();" }
    end
  end

  def following?
    @podcast = Podcast.find(params[:id])
    @current_user.following?(@podcast)
  end

  def new
    @podcast = Podcast.new
  end

  def create
    @podcast = Podcast.new(podcast_params)
    @podcast.save
  end

  private

  def podcast_params
    params.require(:podcast).permit(:itunes_id,
     :image,
     :title,
     :episodes,
     :country,
     :description,
     :language,
     :korean_id,
     :lastest_pub_date_ms,
     :earliest_pub_date_ms,
     :publisher,
     :genres,
     :extra)
  end
end
