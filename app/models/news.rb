class News < ApplicationRecord
	belongs_to :provider, optional: true
	validates :title, uniqueness: true

	belongs_to :user, optional: true
	belongs_to :category
	belongs_to :rss_provider, optional: true
	has_one :question
	has_many :answer, through: :question
	has_one_attached :media

	before_save :check_media

	after_commit :create_notifications, on: [:create]
	

	private
	def create_notifications
		if self.user.present?
	    Notification.create(
	      notify_type: 'news',
	      actor: self.user,
	      user: User.find(self.user.creator_user_id),
	      target: self)
	  end
	end
	def check_media
		if self.media.present? && self.media_url.present?
			errors.add(:base, "Can Not Save Both Media and Media Url")
    		throw(:abort)
		end
	end
end

# News.last(2).first.media.service_url