class Question < ApplicationRecord
	has_many :answers
	belongs_to :news, optional: true
	# validates :news_id, uniqueness: true

end
