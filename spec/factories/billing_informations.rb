FactoryGirl.define do
  factory :billing_information do
    first_name "First name"
    last_name "Last name"
    user

    #https://docs.spreedly.com/test-data
    factory :credit_card, class: "CreditCard" do
      month
      year
      cvv "111"
      factory :visa do
        brand "visa"
        factory :visa_good do
          number 4111111111111111
        end

        factory :visa_bad do
          number 4012888888881881
        end
      end

      factory :master do
        brand "master"
        factory :master_good do
          number 5555555555554444
        end

        factory :master_bad do
          number 5105105105105100
        end
      end

      factory :discover do
        brand "discover"
        factory :discover_good do
          number 6011111111111117
        end

        factory :discover_bad do
          number 6011000990139424
        end
      end

      factory :american_express do
        brand "american_express"
        factory :american_express_good do
          number 378282246310005
        end

        factory :american_express_bad do
          number 371449635398431
        end
      end
    end
  end
end