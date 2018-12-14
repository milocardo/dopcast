class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy, :add_episode_to_playlist]

  def index
    @playlist = Playlist.all
  end

  def show
  end

  # def list_playlists
  #   @episodes = current_user.playlists
  # end

  # def list_friends_episodes
  #   @user = User.find(params[:id])
  #   @episodes = @user.playlists
  # end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.user = current_user
    @playlist.save!
    if params["playlist"]["episode_id"]
      @playlist.episodes << Episode.find(params["playlist"]["episode_id"])
    end
    redirect_to my_profile_path
  end

  def add_episode_to_playlist
    @playlist.episodes << Episode.find(params["episode_id"])
    redirect_to my_profile_path
  end

  def edit
  end

  def update
    @playlist.update(playlist_params)
    redirect_to playlists_path(@playlist)
  end

  def destroy
    @playlist.destroy
    redirect_to playlists_path
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name, :episode)
  end

  def set_playlist
    @playlist = Playlist.find(params[:id])
  end
end
