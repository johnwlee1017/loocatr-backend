class Image < ApplicationRecord
  belongs_to :bathroom

  validates :image_url, presence: true
end
