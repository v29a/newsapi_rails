class RssProvider < ApplicationRecord
	has_many :news
	belongs_to :provider
	belongs_to :category
	has_many :provider_contents
	validates :rss_url, uniqueness: true

end
