class Bathroom < ApplicationRecord
  has_many :time_frames, dependent: :destroy
  has_many :reviews
  has_many :images, dependent: :destroy

  validates :latitude, :longitude, presence: true
end
