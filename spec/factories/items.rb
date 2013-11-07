# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    quantity 1
    shop
    max_adults 1
    published false
    default_price 1.5

    factory :complete_item do
    	default_price { rand(1000) }
    	published true
    	max_adults { RandomHelper.r1(10) }
    	quantity { RandomHelper.r1(10) }
        after(:create) do |c, evaluator|
            language = Language.default
            language ||= create(:language)
            c.descriptions << create(:description,
                describable: c,
                language: language
            )
            RandomHelper.r1(4).times { create(:tagging, taggable: c, tag: Tag::RoomTag.all.sample) }
            RandomHelper.r1(10).times { create(:photo, photoable: c) }
        end
    end
  end
end
