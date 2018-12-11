class CreatePodcasts < ActiveRecord::Migration[5.2]
  def change
    create_table :podcasts do |t|
      t.string :itunes_id
      t.string :image
      t.string :title
      t.string :total_episodes
      t.json :episodes_list
      t.string :country
      t.string :description
      t.string :language
      t.string :korean_id
      t.string :lastest_pub_date_ms
      t.string :earliest_pub_date_ms
      t.string :publisher
      t.string :genres
      t.string :extra

      t.timestamps
    end
  end
end
