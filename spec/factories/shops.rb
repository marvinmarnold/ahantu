# Read about factories at https://github.com/thoughtbot/factory_girl
require 'random_helper'

FactoryGirl.define do
  factory :shop do
    user { create(:shop_owner) }
    location
    published false
    logo "MyString"
    address1 { Faker::Address.street_address }
    address2 { RandomHelper.bi_rand Faker::Address.secondary_address }
    directions { Faker::Lorem.paragraph(sentence_count = 5) }
    website1 "MyString"
    website2 "MyString"
    website3 "MyString"
    website4 "MyString"
    website5 "MyString"
    commission_pct 10

    factory :complete_shop do
        logo { RandomHelper.rand_shop_logo }
        banner { RandomHelper.rand_shop_banner }
        published true
        location { create(:location) }
        after(:create) do |c, evaluator|
            language = Language.default
            language ||= create(:language)
            c.descriptions << create(:description,
                describable: c,
                language: language
            )
            RandomHelper.r1(4).times { create(:tagging, taggable: c, tag: Tag::HotelTag.all.sample) }
            RandomHelper.r1(10).times { create(:photo, photoable: c) }
        end
        factory :complete_shop_w_items do
            after(:create) do |c, evaluator|
                RandomHelper.r1(5).times { create(:complete_item, shop: c) }
            end
        end
    end

  end
end
