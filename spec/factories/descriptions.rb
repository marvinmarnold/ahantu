# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :description do
    language nil
    name "MyString"
    description "MyText"
    describable nil
  end
end
