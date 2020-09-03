class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         belongs_to :role
         has_many :news
  def follow(user)
    Notification.create(notify_type: 'follow', actor: self, user: user)
  end

end
