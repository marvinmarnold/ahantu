class CreditCard < BillingInformation

	validate :validate_card, on: :create

  validates :number, :first_name, :expiration, :brand,
    presence: true

private

	def validate_card
    if !credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors["base"] << message
      end
    end
  end

	def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :brand              => brand,
      :number             => number,
      :verification_value => cvv,
      :month              => expiration.month,
      :year               => expiration.year,
      :first_name         => first_name,
      :last_name          => last_name
    )
  end


end
