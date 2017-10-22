module Times
  extend ActiveSupport::Concern

  def self.four_digit_arr
    DateTime.now.strftime('%H%M').chars
  end

  def self.todays_num
    Date.today.strftime('%u').to_i - 1
  end
end
