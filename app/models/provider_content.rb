class ProviderContent < ApplicationRecord		
	belongs_to :rss_provider
	validates :xml, uniqueness: true

end
