class CreatePodcasts < ActiveRecord::Migration[5.2]
  def change
    create_table :podcasts do |t|
      t.string :title
      t.string :itunes_id
      t.string :total_episodes
      t.string :image
      t.string :publisher_original
      t.string :korean_id

      t.timestamps
    end
  end
end
