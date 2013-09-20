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
          item: create(:item, shop: shop),
        ) }
      end

      factory :cart_submitted do
        state "submitted"
        billing_information { create(:credit_card, user: user) }
      end
    end
  end
end