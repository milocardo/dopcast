class CreatePodcasts < ActiveRecord::Migration[5.2]
  def change
    create_table :podcasts do |t|
      t.string :image
      t.string :title
      t.string :category
      t.string :language
      t.text :description
      t.string :episode

      t.timestamps
    end
  end
end
