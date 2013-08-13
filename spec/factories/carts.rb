# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cart do
    user nil
    shop nil
    total_at_checkout 1.5
    payment_at "2013-08-13 15:10:16"
    payment_amount 1.5
    billing_inform "MyString"
  end
end
