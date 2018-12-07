class CreatePodcasts < ActiveRecord::Migration[5.2]
  def change
    create_table :podcasts do |t|
      t.string :image
      t.string :collection_id
      t.string :collection_name
      t.string :artist_name
      t.string :genre
      t.string :country

      t.timestamps
    end
  end
end
