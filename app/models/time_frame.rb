class TimeFrame < ApplicationRecord
  belongs_to :bathroom

  validates :start, :close, presence: true

  def during_business_hours?(is_opened, now_arr)
    self.start.chars.each_with_index do |start_time, i|
      if start_time.to_i <= now_arr[i].to_i
        is_opened = true
        break
      end
      break if start_time.to_i > now_arr[i].to_i
    end

    if !self.is_overnight
      self.close.chars.each_with_index do |close_time, i|
        break if close_time.to_i > now_arr[i].to_i
        if close_time.to_i <= now_arr[i].to_i
          is_opened = false
          break
        end
      end
    end
    is_opened
  end
end
