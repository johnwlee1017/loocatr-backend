class Review < ApplicationRecord
  belongs_to :bathroom
  belongs_to :user

  validates :ratings, :description, presence: true

  def self.average_ratings(bathroom)
    if !bathroom.reviews.empty?
      bathroom.reviews.reduce(0) { |sum, review| sum += review.ratings } / bathroom.reviews.length
    end
  end
end
