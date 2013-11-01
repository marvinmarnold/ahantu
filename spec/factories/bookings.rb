# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :booking do
    cart
    item
    responsible_name "MyString"
    name_at_checkout "TODO"
    confirmed false
    adults 1
    quantity 1

    factory :complete_booking do
      item { FactoryGirl.create(:complete_item) }
    end
  end
end