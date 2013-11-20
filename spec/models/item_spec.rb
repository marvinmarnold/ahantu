require 'spec_helper'

describe Item do
  it "returns number of available items on a specific date" do
    @i1 = create(:complete_item, max_adults: 3, quantity: 2)
    @booking = create(:booking, item: @i1, cart: create(:cart), adults: 1)
    @line_item = create(:line_item, booking: @booking, booking_at: Date.today)

    expect(@i1.num_available(Date.today)).to eq(1)
    expect(@i1.num_available(Date.tomorrow)).to eq(2)
  end

  it "returns the average price over a continuous period" do
    @i1 = create(:complete_item, default_price: 5)
    create :price_adjustment, start_at: 4.days.from_now, end_at: 7.days.from_now, item: @i1, price: 10

    expect(@i1.price_over_period(Date.today, 4.days.from_now)).to eq 6
  end
end
