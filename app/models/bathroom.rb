class Bathroom < ApplicationRecord
  has_many :time_frames, dependent: :destroy
  has_many :reviews
  has_many :images, dependent: :destroy

  validates :latitude, :longitude, presence: true

  include Times

  def opening
    is_opened = false
    self.time_frames.where(day: Times.todays_num).each do |time_frame|
      is_opened = time_frame.during_business_hours?(is_opened, Times.four_digit_arr)
      break if is_opened
    end
    is_opened
  end

  def self.fetch_bathrooms(cur_lat, cur_lng)
    # opening_bathrooms = .select { |bathroom| bathroom.opening }[0...10]
    self.closest_bathrooms(cur_lat, cur_lng)[0..10].each { |bathroom| bathroom.average_ratings = Review.average_ratings(bathroom) || 0 }
    opening_bathrooms
  end

  def self.closest_bathrooms(cur_lat, cur_lng)
    Bathroom.all.sort_by { |bathroom| DistanceCalculator.distance(cur_lat, cur_lng, bathroom.latitude, bathroom.longitude) }
  end
end
