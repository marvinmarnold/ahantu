class ShopOwnerMailer < ActionMailer::Base
  default :from => "info@ahantu.com"

  def booking_confirmation(cart, shop_owner)
    @user = shop_owner
    @cart = cart
    @url  = "http://example.com/login"
    mail(:to => @user.email, :subject => "Booking confirmation - #{cart.order_number} - #{cart.shop}")
  end
end