require 'spec_helper'
require 'item_availability'

describe Shop do
    before(:each) do
        @shop = create(:shop)
        @i1 = create(:complete_item, shop: @shop, max_adults: 3, quantity: 1, default_price: 11)
        @i2 = create(:complete_item, shop: @shop, max_adults: 1, quantity: 2, default_price: 2)
        @i3 = create(:complete_item, shop: @shop, max_adults: 1, quantity: 1, default_price: 3)
    end

    it "gives all items available on a certain day with a minimum number of adults" do
        @booking = create(:booking, item: @i3, cart: create(:cart), adults: 1)
        @l1 = create(:line_item, booking: @booking, booking_at: Date.today)

        expect(@shop.available_items(Date.today, 1)).to eq(
            [
                ItemAvailability.new(
                    max_adults: 1,
                    item: @i2,
                    quantity: 2
                ),
                ItemAvailability.new(
                    max_adults: 3,
                    item: @i1,
                    quantity: 1
                )
            ]
        )
        expect(@shop.num_available_items(Date.today, 1)).to eq(3)
        expect(@shop.available_items(Date.today, 4)).to eq([])
        expect(@shop.num_available_items(Date.today, 4)).to eq(0)
    end

    it "returns minimum average price over search period for display_price" do
        @search = create(:search, checkin_at: Date.today, checkout_at: 2.days.from_now)
        create :price_adjustment, start_at: Date.today, end_at: 7.days.from_now, item: @i2, price: 10000

        expect(@shop.display_price(@search)).to eq 3
    end
end
