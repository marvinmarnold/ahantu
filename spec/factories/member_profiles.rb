# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member_profile do
    language nil
    password "password"
    password_confirmation "password"
    email { Faker::Internet.email }
  end
end
