class Provider < ApplicationRecord
	has_many :news, dependent: :destroy
	has_many :provider_content, dependent: :destroy
	validates :provider_url, uniqueness: true
end
