# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :city do
    name "MyString"
    province nil

    factory :complete_city do
      province { create(:province) }
    end
  end
end
