class SalespersonMailer < ActionMailer::Base
  default :from => "info@ahantu.com"

  def booking_confirmation(cart, salesperson_user)
    @user = salesperson_user
    @cart = cart
    @url  = "http://example.com/login"
    mail(:to => @user.email, :subject => "Booking confirmation - #{cart.order_number} - #{cart.shop}")
  end

  def welcome_email(profile)
    @email = profile.email
    mail(:to => @email, :subject => I18n.t("shopper_mailer.welcome_email.subject"))
  end
end