FactoryGirl.define do
  factory :billing_information do
    first_name "First name"
    last_name "Last name"
    user

    factory :credit_card, class: "CreditCard" do
      expiration { Date.today }
      brand "visa"
      number "4111111111111111"
      cvv "111"
    end
  end
end