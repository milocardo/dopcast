class EpisodesController < ApplicationController
  def index
    @episode = Episode.all
  end

  def show
    if Episode.where(korean_episode_id: params[:id]).any?
      @episode = Episode.where(korean_episode_id: params[:id])[0]
      @podcast = Podcast.find(@episode.podcast_id)
    elsif Episode.exists?(params[:id])
      @episode = Episode.find(params[:id])
      @podcast = Podcast.find(@episode.podcast_id)
    else
        # Search all the information of an specific episode
        response = HTTParty.get(
          "https://listennotes.p.mashape.com/api/v1/episodes/#{params['id']}",
          headers: {
            "X-Mashape-Key" => ENV['ESPECIFIC_SEARCH_KEY'],
            "Accept" => "application/json"
          }
        )
        # If the podcast doesnt exist yet, create a new podcast
        @episode = Episode.create(
          korean_episode_id: params[:id],
          title: response["title"],
          audio_length: response["audio_length"],
          audio: response["audio"],
          description: response["description"],
          pub_date_ms: response["pub_date_ms"],
          image: response["image"],
          podcast: Podcast.find(params[:podcast])
        )
        @podcast = Podcast.find(params[:podcast])
    end
  end

  # def add_new_comment
  #   @episode = Episode.find(params[:id])
  #   @episode.comments << Episode.new(params[:comment])
  #   # redirect_to :action => :show, :id => @episode
  #   redirect_to episode_path(@episode)
  # end

  def upvote
    @episode = Episode.find(params[:id])
    @episode.upvote_from current_user
    @episode.create_activity(:like, owner: current_user)
  #   respond_to :js
  #   respond_to do |format|
  #     format.js {render inline: "location.reload();" }
  #   end
  # end
    # if request.env['PATH_INFO'] == "/"
      redirect_to episode_path(@episode)
    # else
      # redirect_to root_path
    end


  def downvote
    @episode = Episode.find(params[:id])
    @episode.downvote_from current_user
    @episode.create_activity(:dislike, owner: current_user)
    # respond_to :js
    # respond_to do |format|
    #   format.js {render inline: "location.reload();" }
    # end
    # if request.env['PATH_INFO'] == "/"
      redirect_to episode_path(@episode)
    # else
    #   redirect_to root_path
    # end
  end

  def follow
    @episode = Episode.find(params[:id])
    current_user.follow(@episode)
    @follow = Follow.find_by(follower: @current_user, followable: @episode)
    respond_to :js
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  def unfollow
    @episode = Episode.find(params[:id])
    current_user.stop_following(@episode)
    respond_to :js
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  def following?
    @episode = Episode.find(params[:id])
    @current_user.following?(@episode)
  end

  def new
    @episode = Episode.new
  end

  def create
    @episode = Episode.new(params[:episode])
    @episode.save
  end
end
