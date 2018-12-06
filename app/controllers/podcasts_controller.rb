      require 'json'

class PodcastsController < ApplicationController
  def index
    if params[:query].present?
      filepath = "https://itunes.apple.com/search?term=#{params[:query]}"
      podcasts_info = File.read(filepath)
      podcasts = JSON.parse(podcasts_info)

      raise

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

  # def index_subscription
  #   @podcasts = User.podcasts
  # end

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
