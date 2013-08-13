class BillingInformation < ActiveRecord::Base
	belongs_to :user

	def validate?
		true
	end
end
