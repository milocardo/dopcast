class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.references :podcast, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
