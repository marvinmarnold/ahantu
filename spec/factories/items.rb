# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    quantity 1
    shop nil
    max_adults 1
    published false
    default_price 1.5
    short "XXX"

    factory :complete_item do 
    	default_price { rand(1000) }
    	published true
    	max_adults { RandomHelper.r1(10) }
    	quantity { RandomHelper.r1(10) }
        after(:create) do |c, evaluator|
            c.descriptions << create(:description,
                describable: c,
                language: Language.default
            )
        end
    end
  end
end
