class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.references :podcast, foreign_key: true
      t.string :audio_length
      t.string :title
      t.string :audio
      t.text :description
      t.string :pub_date_ms
      t.string :image
      t.string :korean_episode_id
      t.string :podcast

      t.timestamps
    end
  end
end
