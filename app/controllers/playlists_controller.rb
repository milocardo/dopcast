class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]

  def index
    @playlist = Playlist.all
  end

  def show
    set_playlist
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.save
    redirect_to playlist_path(@playlist)
  end

  def update
    set_playlist
    @playlist.update(playlist_params)
    redirect_to playlists_path(@playlist)
  end

  def destroy
    set_playlist
    @playlist.destroy
    redirect_to playlists_path
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name, :address)
  end

  def set_playlist
    @playlist = Playlist.find(params[:id])
  end
end
