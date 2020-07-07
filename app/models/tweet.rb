class Tweet < ApplicationRecord
  self.per_page = 10

  belongs_to :user

  validates :user, presence: true

  validates :body, presence: true, length: { maximum: 280 }
end
