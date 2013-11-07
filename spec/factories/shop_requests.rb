# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shop_request do
    user nil
    state "MyString"
    request "MyText"
  end
end
