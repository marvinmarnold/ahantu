# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :language do
    name "MyString"
    abbr "MyString"
    default false
  end
end
