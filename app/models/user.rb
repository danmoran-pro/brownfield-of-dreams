class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :inverse_friendships,
           class_name: 'Friendship',
           foreign_key: 'friend_id',
           dependent: :destroy,
           inverse_of: :friendships
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  validates :email, uniqueness: true, presence: true
  validates :first_name, presence: true
  validates :password, presence: true
  enum role: { default: 0, admin: 1 }
  has_secure_password
  validates :uid, presence: false
  validates :github_token, presence: false
  validates :username, presence: false
  validates :provider, presence: false

  def friend?(username)
    user = User.find_by(username: username)
    friends.include?(user)
  end
end
