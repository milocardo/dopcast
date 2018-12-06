class PodcastsController < ApplicationController
  def index
    @podcasts = Podcast.all
  end

  def show
    @podcast = Podcast.find(params[:id])
  end

  # def index_subscription
  #   @podcasts = User.podcasts
  # end

  def add_new_comment
    @podcast = Podcast.find(params[:id])
    @podcast.comments << Podcast.new(params[:comment])
    # redirect_to :action => :show, :id => @podcast
    redirect_to podcast_path(@podcast)
  end

  def upvote
    @podcast = Podcast.find(params[:id])
    @podcast.upvote_from current_user
    redirect_to podcast_path(@podcast)
  end

  def downvote
    @podcast = Podcast.find(params[:id])
    @podcast.downvote_from current_user
    redirect_to podcast_path(@podcast)
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
