class Category < ApplicationRecord
	has_many :news
	has_many :rss_providers
	has_many :providers, through: :rss_providers 

end
