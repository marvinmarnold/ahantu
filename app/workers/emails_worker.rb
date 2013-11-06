class EmailsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(cart_id)
    cart = Cart.find cart_id
    #send email to all responsibles
    cart.responsibles.each do |r|
      SalespersonMailer.booking_confirmation(cart, r).deliver
    end
    ShopperMailer.booking_confirmation(cart, cart.user).deliver
    ShopOwnerMailer.booking_confirmation(cart, cart.shop.owner).deliver
  end
end