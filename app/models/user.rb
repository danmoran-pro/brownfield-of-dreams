class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates :column, presence: value
  validates :column, presence: value
  enum role: { default: 0, admin: 1 }
  has_secure_password
end
