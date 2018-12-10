class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def follow
    @user = User.find(params[:id])
    current_user.follow(@user)
    @follow = Follow.find_by(follower: current_user, followable: @user)
    respond_to :js
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.stop_following(@user)
    respond_to :js
  end

  # def following?
  #   @current_user.follow?(@user)
  # end

  # def follow_podcast
  #   @current_user.follow(@podcast)
  #   @follow = Follow.find_by(follower: @current_user)
  #   respond_to :js
  # end

  # def unfollow_podcast
  #   @current_user.stop_following(@podcast)
  #   respond_to :js
  # end

  # def following_podcast?
  #   @current_user.following?(@podcast)
  # end
end
