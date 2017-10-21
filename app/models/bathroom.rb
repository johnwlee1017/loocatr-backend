class Bathroom < ApplicationRecord
  has_many :time_frames, dependent: :destroy
  has_many :reviews
  has_many :images, dependent: :destroy

  validates :latitude, :longitude, presence: true

  def opening
    is_opened = false
    now_arr = DateTime.now.strftime('%H%M').chars
    self.time_frames.where(day: Date.today.strftime('%u').to_i - 1).each do |time_frame|
      is_opened = time_frame.during_business_hours?(is_opened, now_arr)
      break if is_opened
    end
    is_opened
  end
end
