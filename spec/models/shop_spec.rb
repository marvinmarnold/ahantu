require 'spec_helper'
require 'item_availability'

describe Shop do
  it "gives all items available on a certain day with a minimum number of adults" do
    @shop = create(:shop)
    @i1 = create(:complete_item, shop: @shop, max_adults: 3, quantity: 1)
    @i2 = create(:complete_item, shop: @shop, max_adults: 1, quantity: 2)
    @i3 = create(:complete_item, shop: @shop, max_adults: 1, quantity: 1)
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
end
