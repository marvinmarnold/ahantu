class User < ActiveRecord::Base
	has_many :billing_informations
	has_many :credit_cards
	has_many :carts

end
