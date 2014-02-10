every 1.day, :at => '10am' do
  runner "Cart.finalize_current_bookings"
end