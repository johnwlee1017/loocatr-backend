class Bathroom < ApplicationRecord
  has_many :time_frames
  has_many :reviews
  has_many :images
end
