class AddForiegnKey < ActiveRecord::Migration[6.0]
  def change
  	add_reference :news, :category, foriegn_key: true 
  	add_reference :news, :rss_provider, foriegn_key: true 
  	add_reference :categories, :provider_content, foriegn_key: true 
  	add_reference :rss_providers, :category, foriegn_key: true 
  	add_reference :rss_providers, :provider, foriegn_key: true 
  	add_reference :provider_contents, :rss_provider, foriegn_key: true 
  	
  end
end
