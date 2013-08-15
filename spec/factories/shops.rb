# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shop do
    user nil
    city nil
    published false
    logo "MyString"
    address1 "MyString"
    address2 "MyString"
    directions "MyText"
    website1 "MyString"
    website2 "MyString"
    website3 "MyString"
    website4 "MyString"
    website5 "MyString"

  end
end
