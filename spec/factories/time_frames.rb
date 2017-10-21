FactoryGirl.define do
  factory :time_frame do
    day Date.today.strftime('%u').to_i
    is_overnight true
    start '0010'
    close '2350'
  end
end
