require 'json'
require 'open-uri'

class PodcastsController < ApplicationController
  def index
    @podcasts = Podcast.all
    if params[:query].present?

      url = "https://itunes.apple.com/search?term=#{params[:query]}&entity=podcast&limit=100"
      podcasts_serialized = open(url).read
      @podcasts = JSON.parse(podcasts_serialized)

      @podcasts["results"].each do |podcast|
        Podcast.create(image: podcast["artworkUrl600"],
          collection_id: podcast["collectionId"],
          collection_name:podcast["collectionName"],
          artist_name: podcast["artistName"],
          genre: podcast["primaryGenreName"],
          country: podcast["country"],
          )
      end
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

  def new
    @podcast = Podcast.new
  end

  def create
    @podcast = Podcast.new(podcast_params)
    @podcast.save
  end

  private

  def podcast_params
    params.require(:podcast).permit(:image, :collection_id, :collection_name, :artist_name, :genre, :country)
  end
end
