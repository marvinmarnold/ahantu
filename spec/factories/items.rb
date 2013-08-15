# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    quantity "MyString"
    shop nil
    max_adults 1
    published false
    default_price 1.5
  end
end
