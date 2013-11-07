# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
  	after(:create) do |c, evaluator|
      language = Language.default
      language ||= create(:language)
      c.descriptions << create(:description,
        describable: c,
        language: language
      )
    end

    factory :hotel_tag, class: "Tag::HotelTag" do
    end
  end
end
