class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable, only: :create
  respond_to :js

  def create
    @comment = @commentable.comments.new do |comment|
      comment.comment = params[:comment_text]
      comment.user = current_user
    end
    if !params[:comment_text].empty?
      if @commentable_type == "Episode"
        @comment.save 
        redirect_to episode_path(Episode.find(params[:episode_id]))
      else
        @comment.save
        redirect_to podcast_path(Podcast.find(params[:podcast_id]))
      end
    else 
      if @commentable_type == "Episode"
        redirect_to episode_path(params[:episode_id])
      else
        redirect_to podcast_path(params[:podcast_id]) 
      end
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment_id = params[:id]
    @comment.destroy
  end

  private

  def find_commentable
    @commentable_type = params[:commentable_type].classify
    @commentable = @commentable_type.constantize.find(params[:commentable_id])
  end
end
