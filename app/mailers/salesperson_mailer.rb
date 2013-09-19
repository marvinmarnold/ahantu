class SalespersonMailer < ActionMailer::Base
  default :from => "info@ahantu.com"

  def booking_confirmation(cart, salesperson_user)
    @user = salesperson_user
    @url  = "http://example.com/login"
    mail(:to => @user.email, :subject => "Booking confirmation - #{cart.order_number} - #{cart.shop}")
  end
end