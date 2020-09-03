class AddForiegnKeyOfUserInNews < ActiveRecord::Migration[6.0]
  def change
  	add_reference :news, :user, foriegn_key: true 
  end
end
