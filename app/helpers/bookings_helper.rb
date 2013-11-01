module BookingsHelper
  def booking_short(booking)
    booking.to_s + ", " + booking_dates(booking)
  end

  def booking_dates(booking)
    l(booking.checkin) + " - " + l(booking.checkout)
  end
end
