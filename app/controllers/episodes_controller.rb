class EpisodesController < ApplicationController
  def index
    @episode = Episode.all
  end

  def show
    @episode = Episode.find(params[:id])
    @podcast = Podcast.find(@episode.podcast_id)
  end

  def new
    @episode = Episode.new
  end

  def create
    @episode = Episode.new(params[:episode])
    @episode.save
  end
end
