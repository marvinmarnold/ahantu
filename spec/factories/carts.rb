# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cart do
    search
    user
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

      factory :cart_ready_to_authorize do
        search
        billing_information { create(:credit_card, user: user) }
        email "marvin@ahantu.com"
        phone "+34666891897"
        after(:create) do |c, evaluator|
          c.send :prepare_for_checkout
        end

        factory :cart_submitted do
          state "payment_received"
        end
      end
    end
  end
end