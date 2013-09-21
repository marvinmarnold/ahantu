# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    type ""
    user nil
    value "MyString"

    factory :email_address, class: "EmailAddress" do

    end
  end
end
