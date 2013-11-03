# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :search do
    keyword "MyString"
    checkin_at { Date.tomorrow }
    checkout_at { checkin_at + 1.weeks }
    user
    shop nil
  end
end
