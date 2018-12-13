class RemoveEpisodeIdFromPlaylist < ActiveRecord::Migration[5.2]
  def change
    remove_column :playlists, :episode_id
  end
end
