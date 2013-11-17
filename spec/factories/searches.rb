# Read about factories at https://github.com/thoughtbot/factory_girl
require 'random_helper'

FactoryGirl.define do
  factory :search do
    keyword "MyString"
    checkin_at { Date.tomorrow }
    checkout_at { checkin_at + 1.weeks }
    user
    shop nil

    factory :complete_search do
      after(:create) do |c, evaluator|
        RandomHelper.r1(3).times { create(:room_search, search: c) }
      end
    end
  end
end
