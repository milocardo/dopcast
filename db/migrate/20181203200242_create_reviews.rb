class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.references :user, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
