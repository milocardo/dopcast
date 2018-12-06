class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @podcasts = Podcast.all
    @episodes = Episode.all
  end

end
