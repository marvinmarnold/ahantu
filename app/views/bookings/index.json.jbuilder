json.array!(@bookings) do |booking|
  json.extract! booking, :cart_id, :item_id, :responsible_first_name, :responsible_last_name, :adults, :name_at_checkout, :quantity
  json.url booking_url(booking, format: :json)
end
