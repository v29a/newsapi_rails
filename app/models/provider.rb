class Provider < ApplicationRecord
	has_many :news
	has_many :provider_content
	validates :provider_url, uniqueness: true
end
