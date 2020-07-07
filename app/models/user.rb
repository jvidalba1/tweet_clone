class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable

  self.per_page = 10

  has_many :tweets

  acts_as_followable
  acts_as_follower

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
