class CreateBathrooms < ActiveRecord::Migration[5.1]
  def change
    create_table :bathrooms do |t|
      t.string :location_name
      t.decimal :latitude, {:precision=>10, :scale=>6}
      t.decimal :longitude, {:precision=>10, :scale=>6}
      t.boolean :over_21
      t.boolean :handicapped
      t.boolean :family
      t.boolean :customer_only
      t.float :average_ratings, default: 0
      t.timestamps
    end
  end
end
