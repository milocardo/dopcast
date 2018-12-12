require 'json'
require 'open-uri'

class PodcastsController < ApplicationController
  def index
    if params[:query].present?
      # Search all the podcasts with the query params
      @podcasts = HTTParty.get(
       "https://listennotes.p.mashape.com/api/v1/search?type=podcast&q=#{params[:query]}",
        headers: {
          "X-Mashape-Key" => ENV['FULL_SEARCH_KEY'],
          "Accept" => "application/json"
        }
      )

      @podcasts["results"].each do |podcast_info|
        #See if the podcast is on to the database
        podcast = Podcast.find_or_initialize_by(itunes_id: podcast_info['itunes_id'])
        next if podcast.persisted?
        #Search for all the information off the specific podcast
        response = HTTParty.get(
          "https://listennotes.p.mashape.com/api/v1/podcasts/#{podcast_info['id']}?next_episode_pub_date=1479154463000&sort=recent_first",
          headers: {
            "X-Mashape-Key" => ENV['ESPECIFIC_SEARCH_KEY'],
            "Accept" => "application/json"
          }
        )
        #If the podcast doesnt exist yet, create a new podcast
        podcast.update!(
          total_episodes: response["total_episodes"],
          itunes_id: response["itunes_id"],
          image: response["image"],
          title: response["title_original"],
          episodes_list: response["episodes"],
          country: response["country"],
          description: response["description"],
          language: response["language"],
          lastest_pub_date_ms: response["lastest_pub_date_ms"],
          earliest_pub_date_ms: response["earliest_pub_date_ms"],
          publisher: response["publisher"],
          genres: response["genres"],
          extra: response["extra"]
        )
      end
      #Search for all the episodes with the query params
      @episodes = HTTParty.get( "https://listennotes.p.mashape.com/api/v1/search?type=episode&q=#{params[:query]}",
        headers:{
          "X-Mashape-Key" => ENV['FULL_SEARCH_KEY'],
          "Accept" => "application/json"
        }
      )

      @episodes["results"].each do |episode_info|
    # binding.pry
        episode = Episode.find_or_initialize_by(korean_episode_id: episode_info['id'])
        next if episode.persisted?
        #Search for the information of the podcast which the episode is nested on
        podcast_info = HTTParty.get "https://listennotes.p.mashape.com/api/v1/podcasts/#{episode_info["podcast_id"]}",
          headers:{
            "X-Mashape-Key" => ENV['ESPECIFIC_SEARCH_KEY'],
            "Accept" => "application/json"
          }
          podcast = Podcast.find_or_initialize_by(itunes_id: podcast_info['itunes_id'])
          unless podcast.persisted?
          #If the podcast doesnt exist yet, create a new podcast
            podcast.update!(
              total_episodes: podcast_info["total_episodes"],
              itunes_id: podcast_info["itunes_id"],
              image: podcast_info["image"],
              title: podcast_info["title"],
              episodes_list: podcast_info["episodes"],
              country: podcast_info["country"],
              description: podcast_info["description"],
              language: podcast_info["language"],
              lastest_pub_date_ms: podcast_info["lastest_pub_date_ms"],
              earliest_pub_date_ms: podcast_info["earliest_pub_date_ms"],
              publisher: podcast_info["publisher"],
              genres: podcast_info["genres"],
              extra: podcast_info["extra"]
            )
          end
        #Search all the information of an specific episode
        response = HTTParty.get "https://listennotes.p.mashape.com/api/v1/episodes/#{episode_info['id']}",
          headers:{
            "X-Mashape-Key" => ENV['ESPECIFIC_SEARCH_KEY'],
            "Accept" => "application/json"
          }
        #If the podcast doesnt exist yet, create a new podcast
        # podcast = Podcast.last
        episode.update!(
          # podcast_id: podcast["id"],
          title: response["title"],
          audio_length: response["audio_length"],
          audio: response["audio"],
          description: response["description"],
          pub_date_ms: response["pub_date_ms"],
          image: response["image"],
          podcast: podcast
        )
      end
      @podcasts = PgSearch.multisearch(params[:query]).where(:searchable_type => "Podcast")
      @episodes = PgSearch.multisearch(params[:query]).where(:searchable_type => "Episode")
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
     :episodes_list,
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
