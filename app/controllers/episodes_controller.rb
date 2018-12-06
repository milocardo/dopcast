class EpisodesController < ApplicationController
  def index
    @episode = Episode.all
  end

  def show
    @episode = Episode.find(params[:id])
    @podcast = Podcast.find(@episode.podcast_id)
  end

  def add_new_comment
    @episode = Episode.find(params[:id])
    @episode.comments << Episode.new(params[:comment])
    # redirect_to :action => :show, :id => @episode
    redirect_to episode_path(@episode)
  end

  def upvote
    @episode = Episode.find(params[:id])
    @episode.upvote_from current_user
    redirect_to episode_path(@episode)
  end

  def downvote
    @episode = Episode.find(params[:id])
    @episode.downvote_from current_user
    redirect_to episode_path(@episode)
  end

  def new
    @episode = Episode.new
  end

  def create
    @episode = Episode.new(params[:episode])
    @episode.save
  end
end
