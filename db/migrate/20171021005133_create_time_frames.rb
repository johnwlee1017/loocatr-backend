class CreateTimeFrames < ActiveRecord::Migration[5.1]
  def change
    create_table :time_frames do |t|
      t.string :day
      t.boolean :is_overnight
      t.string :open
      t.string :closed
      t.references :bathroom, foreign_key: true

      t.timestamps
    end
  end
end
