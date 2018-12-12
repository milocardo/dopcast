class ActivitiesController < ApplicationController
  layout false, only: :show
  before_action :authenticate_user!, only: :yours

  def index
    @activities = PublicActivity::Activity.order("created_at DESC").all

    respond_to do |format|
      format.html
    end
  end

  def all_activities
    @activities = PublicActivity::Activity.order("created_at DESC").all

    respond_to do |format|
      format.html
    end
  end

  def yours
    @activities = PublicActivity::Activity.order("created_at DESC").where(owner_type: "User", owner_id: current_user).all

    respond_to do |format|
      format.html
    end
  end

  def feed
    @activities = PublicActivity::Activity.order("created_at DESC").where(owner_type: "User", owner_id: current_user.all_following).all

    respond_to do |format|
      format.html
    end
  end

  def followers_feed
    @activities = PublicActivity::Activity.order("created_at DESC").where(owner_type: "User", owner_id: current_user.followers).all

    respond_to do |format|
      format.html
    end
  end

  def show
    @activity = PublicActivity::Activity.find(params[:id])

    respond_to do |format|
      format.html
    end
  end


end
