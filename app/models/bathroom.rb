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
end
