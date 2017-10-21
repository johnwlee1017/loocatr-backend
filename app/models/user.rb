class User < ApplicationRecord
  has_many :reviews, dependent: :destroy

  validates :username, :email, presence: true
end
