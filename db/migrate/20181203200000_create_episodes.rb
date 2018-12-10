class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.string :audio
      t.references :podcast, foreign_key: true
      t.string :korean_podcast_id
      t.string :itunes_id
      t.string :audio_length
      t.string :guest
      t.text :description_original
      t.string :genres
      t.string :image
      t.string :publisher_original
      t.string :title_original
      t.string :pub_date_ms
      t.string :podcast_title_original

      t.timestamps
    end
  end
end
