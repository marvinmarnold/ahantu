module CartsHelper
	def cart_bookings_attributes_id(b_id, i_id)
		"cart_bookings_attributes_#{b_id}_item_id_#{i_id}"
	end

  def can_one_click_checkout?(cart)
    cart.bookings.size == 1
  end

  def show_checkout_button?
    current_cart.present? &&
    params[:controller] != "carts" &&
    params[:action] != "edit"
  end
end
