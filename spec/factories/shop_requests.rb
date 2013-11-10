# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shop_request do
    shop_owner_profile { create(:shop_owner).profile }
    salesperson_profile_id nil
    location { create(:location) }
    shop nil
    request "MyText"
    shop_name "Some shop"
  end
end