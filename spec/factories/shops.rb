# Read about factories at https://github.com/thoughtbot/factory_girl
require 'random_helper'

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
    commission_pct 10

    factory :complete_shop do
        logo { RandomHelper.rand_shop_logo }
        published true
        city { City.all.sample }
        after(:create) do |c, evaluator|
            c.descriptions << create(:description,
                describable: c,
                language: Language.default
            )
            RandomHelper.r1(4).times { create(:tagging, taggable: c, tag: HotelTag.all.sample) }
        end
        factory :complete_shop_w_items do
            after(:create) do |c, evaluator|
                RandomHelper.r1(5).times { create(:complete_item, shop: c) }
            end
        end
    end

  end
end
