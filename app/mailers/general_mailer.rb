class GeneralMailer < ActionMailer::Base
  def receive(email)
  	if order = Cart.find_cart(email.body)
  		acknowledge_confirmation(email)
  	else
  		reject_confirmation(email)
  	end
  end

  def acknowledge_confirmation(email)
		#TODO
  end

  def reject_confirmation(email)
  	#TODO
  end
end