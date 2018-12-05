class SubscriptionsController < ApplicationController
  # def index
  #   @user = User.find(params[:id])
  #   @subscriptions = Subscription.where(user_id: @user.id)
  # end

  def list_podcasts
    @podcasts = current_user.podcasts
  end

  def list_friends_podcasts
    @user = User.find(params[:id])
    @podcasts = @user.podcasts
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @user = current_user
    @podcast = Podcast.find(params[:id])
    @subscription = Subscription.new(user: @user, podcast: @podcast)
    @subscription.save
  end
end
