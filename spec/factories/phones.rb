# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phone do
    shop nil
    number "MyString"
    name "MyString"
  end
end
