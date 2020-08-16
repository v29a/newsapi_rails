class AddReferencesInNews < ActiveRecord::Migration[6.0]
  def change
  	add_reference :news, :provider, foriegn_key: true 
  end
end
