class BillingInformation < ActiveRecord::Base
	belongs_to :user
	validates :brand, :number, :cvv, :first_name, :last_name, :expiration,
		presence: true

	def validate?
		true
	end
end