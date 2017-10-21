class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :ratings
      t.string :description
      t.references :bathroom, foreign_key: true
      t.references :user_id, foreign_key: true

      t.timestamps
    end
  end
end
