module CartsHelper
	def cart_bookings_attributes_id(b_id, i_id)
		"cart_bookings_attributes_#{b_id}_item_id_#{i_id}"
	end
end
