class AddCreatorIdInUser < ActiveRecord::Migration[6.0]
  def change
	add_column :users, :creator_user_id, :integer
end
end
