class CreditCard < BillingInformation
  # attr_accessor :name_on_card
	validate :validate_card, on: :create
  validates :number, :expiration, :brand, :cvv, :last_name,
    presence: true

  CREDIT_CARD_TYPES = {
    "Visa" => "visa",
    "MasterCard" => "master",
    "Discover" => "discover",
    "Maestro" => "maestro",
    "JCB" => "jcb",
    "American Express" => "american_express",
    "Diners Club" => "diners_club"
  }

  def to_s
    "#{CREDIT_CARD_TYPES.key(brand)} - #{name_on_card} - #{last_four}"
  end

  def short
    "#{CREDIT_CARD_TYPES.key(brand)} - #{last_four}"
  end

  def last_four
    number[-4,4]
  end

  def name_on_card
    self.last_name
  end

  def name_on_card=(n)
    self[:last_name] = n
  end

  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :brand              => brand,
      :number             => number,
      :verification_value => cvv,
      :month              => expiration.month,
      :year               => expiration.year,
      :name               => name_on_card,
    )
  end

private

	def validate_card
    if !credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors["credit_card"] << message
      end
    end
  end

end
