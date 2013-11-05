# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    ancestry nil
    name { Faker::Lorem.words.join " " }
  end
end
