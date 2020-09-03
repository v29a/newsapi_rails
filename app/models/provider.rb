class Provider < ApplicationRecord
	has_many :news, dependent: :destroy
	has_many :provider_contents, dependent: :destroy
	validates :provider_url, uniqueness: true
	has_many :rss_providers
	has_many :categories, through: :rss_providers 
end
