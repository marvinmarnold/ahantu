# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :booking do
    cart nil
    item nil
    responsible_first_name "MyString"
    responsible_last_name "MyString"
    adults 1
    name_at_checkout "MyString"
    quantity 1
  end
end
