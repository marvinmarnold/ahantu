# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :search do
    keyword "MyString"
    checkin_at "2013-08-15"
    checkout_at "2013-08-15"
    user nil
    item nil
    shop nil
  end
end
