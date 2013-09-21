# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :confirmation do
    message "MyString"
    type ""
    booking nil
    sent_at "2013-09-20 16:33:32"

    factory :email_confirmation, class: "EmailConfirmation" do
      recipient { create(:email_address) }
      sender { create(:email_address) }
    end
  end
end
