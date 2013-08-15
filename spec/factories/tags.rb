# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
  	after(:create) do |c, evaluator|
      c.descriptions << create(:description,
        describable: c,
        language: Language.default
      )
    end
  end
end
