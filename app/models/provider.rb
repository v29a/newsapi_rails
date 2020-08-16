class Provider < ApplicationRecord
	has_many :news
	validates :provider_url, uniqueness: true
end
