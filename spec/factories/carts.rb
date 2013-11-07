# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cart do
    user
    payment_at nil
    payment_amount nil
    billing_information nil

    factory :cart_shopping do
      after(:create) do |c, evaluator|
        shop = create(:complete_shop_w_items)
        RandomHelper.r1(10).times { create(
          :booking,
          cart: c,
          item: shop.items.sample,
        ) }
      end

      factory :cart_authorizing_payment do
        billing_information { create(:credit_card, user: user) }
        email "marvin@ahantu.com"
        phone "+34666891897"
        after(:create) do |c, evaluator|
          c.authorize_payment
        end

        factory :cart_submitted do
          state "submitted"
        end
      end
    end
  end
end