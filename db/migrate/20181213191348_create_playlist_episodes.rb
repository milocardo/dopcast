class CreatePlaylistEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :playlist_episodes do |t|
      t.belongs_to :episode, index: true
      t.belongs_to :playlist, index: true

      t.timestamps
    end
  end
end
