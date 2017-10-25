class AddIsPrivateAndUserIdToBathrooms < ActiveRecord::Migration[5.1]
  def change
    add_column :bathrooms, :is_private, :boolean
    add_column :bathrooms, :user_id, :string
  end
end
