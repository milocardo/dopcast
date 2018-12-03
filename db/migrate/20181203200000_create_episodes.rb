class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.string :title
      t.references :podcast, foreign_key: true
      t.integer :duration
      t.text :description
      t.string :guest
      t.date :date

      t.timestamps
    end
  end
end
