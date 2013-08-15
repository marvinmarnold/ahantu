# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :description do
    language nil
    name { Faker::Lorem.words.join " "}
    description { Faker::Lorem.sentences.join " " }
    describable nil
  end
end
