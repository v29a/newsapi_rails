class News < ApplicationRecord
	belongs_to :provider
	validates :title, uniqueness: true

end
