# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    photo { RandomHelper.rand_shop_photo }
    photoable nil
  end
end
