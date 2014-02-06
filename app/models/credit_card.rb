class CreditCard < BillingInformation
  # attr_accessor :name_on_card
	validate :validate_card, on: :create
  validates :number, :expiration, :brand, :last_name,
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

  def store
    response = ::STANDARD_GATEWAY.store(credit_card, verify: true)
    if response.success?
      save_to_gateway
      update_attributes(
        number: number[-4,4],
        cvv: nil,
        saved_gateway_id: response.params["billingid"]
      )
    end

    response.success?
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

  ##############################################################################################################
  ### state machine
  ##############################################################################################################

  state_machine :state, :initial => :unsaved_to_gateway do
    state :unsaved_to_gateway do
      validates :cvv, presence: true
    end

    state :saved_to_gateway do
    end

    event :save_to_gateway do
      transition :unsaved_to_gateway => :saved_to_gateway
    end
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
