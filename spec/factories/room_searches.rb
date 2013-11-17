# Read about factories at https://github.com/thoughtbot/factory_girl
require 'random_helper'

FactoryGirl.define do
  factory :room_search do
    search nil
    adults { RandomHelper.r1(5) }
  end
end
