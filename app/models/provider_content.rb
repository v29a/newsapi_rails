class ProviderContent < ApplicationRecord
	belongs_to :provider
	validates :xml, uniqueness: true

end
