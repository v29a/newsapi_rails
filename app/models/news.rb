class News < ApplicationRecord
	belongs_to :provider, optional: true
	validates :title, uniqueness: true

	belongs_to :user, optional: true
	belongs_to :category
	belongs_to :rss_provider, optional: true

	after_commit :create_notifications, on: [:create]
	def create_notifications
		if self.user.present?
	    Notification.create(
	      notify_type: 'news',
	      actor: self.user,
	      user: User.find(self.user.creator_user_id),
	      target: self)
	  end
	end
end
