require 'json'
require 'open-uri'

class PodcastsController < ApplicationController
  def index
    @podcasts = Podcast.all
    if params[:query].present?

      url = "https://itunes.apple.com/search?term=#{params[:query]}&entity=podcast&limit=100"
      podcasts_serialized = open(url).read
      @podcasts = JSON.parse(podcasts_serialized)

      url = "https://itunes.apple.com/search?term=#{params[:query]}&kind=podcast-&limit=100"
      episodes_serialized = open(url).read
      @episodes = JSON.parse(episodes_serialized)
    else
      @podcasts = Podcast.all
    end
  end

  def show
    @podcast = Podcast.find(params[:id])
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

  def new
    @podcast = Podcast.new
  end

  def create
    @podcast = Podcast.new(podcast_params)
    @podcast.save
  end

  private

  def podcast_params
    params.require(:podcast).permit(:title, :author)
  end
end
