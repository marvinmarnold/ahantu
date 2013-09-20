# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    type ""
    user nil
    value "MyString"
  end
end
