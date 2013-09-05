# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sm do
    cart nil
    message "MyText"
    phone nil
    incoming false
    sent_at "2013-09-04 20:22:50"
  end
end
