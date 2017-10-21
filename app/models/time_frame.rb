class TimeFrame < ApplicationRecord
  belongs_to :bathroom

  validates :start, :close, presence: true
end
