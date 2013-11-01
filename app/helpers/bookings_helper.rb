module BookingsHelper

  def booking_dates(booking)
    l(booking.checkin) + " - " + l(booking.checkout)
  end
end
