class EmailsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def send_booking_confirmations(cart_id)
    cart = Cart.find cart_id
    #send email to all responsibles
    cart.responsibles.each do |r|
      SalespersonMailer.booking_confirmation(cart, r).deliver
    end
    ShopperMailer.booking_confirmation(cart, cart.user).deliver
    ShopOwnerMailer.booking_confirmation(cart, cart.shop.owner).deliver
  end

  def send_welcome_email_async(member_profile_id)
    member_profile = MemberProfile.find(member_profile_id)
    "#{member_profile.role}_mailer".constantize.welcome_email(member_profile).deliver
  end
end