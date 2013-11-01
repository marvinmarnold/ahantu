# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    factory :member do
      profile { create(:member_profile) }
      factory :shop_owner do
        profile { create(:member_profile, role: "shop_owner", language: Language.default) }
      end
    end
  end
end
