# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :confirmation do
    message "MyString"
    type ""
    text "MyText"
    booking nil
    sent_at "2013-09-20 16:33:32"
  end
end
