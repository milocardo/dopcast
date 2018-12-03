class AddPlaylistToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :playlist, :string
  end
end
