class AddForeignKeyInUser < ActiveRecord::Migration[6.0]
  def change
  	add_reference :users, :role, foriegn_key: true 
  end
end
