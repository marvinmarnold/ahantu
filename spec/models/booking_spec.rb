require 'spec_helper'

describe Booking do
  it "returns correct checkin and checkout date" do
    booking = create(:complete_booking)
    (0..2).each { |i| create(:line_item, booking: booking, booking_at: Date.today + i.days) }
    expect(booking.checkin).to eq(Date.today)
    expect(booking.checkout).to eq(Date.today + 2.days)
  end
end
