class TimeFrame < ApplicationRecord
  belongs_to :bathroom

  validates :open, :close, presence: true
end
