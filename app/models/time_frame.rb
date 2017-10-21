class TimeFrame < ApplicationRecord
  belongs_to :bathroom

  validates :open, :closed, presence: true
end
