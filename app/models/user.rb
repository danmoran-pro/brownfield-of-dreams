class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates :first_name, presence: true
  validates :password, presence: true
  enum role: { default: 0, admin: 1 }
  has_secure_password
  validates :uid, presence: false
  validates :github_token, presence: false
  validates :username, presence: false
  validates :provider, presence: false
end
