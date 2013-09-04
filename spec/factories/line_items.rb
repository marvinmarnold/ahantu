# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :line_item do
    booking nil
    unit_price_at_checkout 1.5
    booking_at "2013-09-04"
  end
end
