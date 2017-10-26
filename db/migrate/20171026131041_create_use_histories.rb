class CreateUseHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :use_histories do |t|
      t.integer :bathroom_id
      t.string :user_id

      t.timestamps
    end
  end
end
