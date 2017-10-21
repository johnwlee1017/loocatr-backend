class Review < ApplicationRecord
  belongs_to :bathroom
  belongs_to :user

  validates :ratings, :description, presence: true
end
