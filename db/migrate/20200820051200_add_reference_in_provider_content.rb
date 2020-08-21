class AddReferenceInProviderContent < ActiveRecord::Migration[6.0]
  def change
  	add_reference :provider_contents, :provider, foriegn_key: true 
  end
end
