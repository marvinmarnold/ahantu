class CreditCard < BillingInformation

  CREDIT_CARD_TYPES = {
    "Visa" => "visa",
    "MasterCard" => "master",
    "Discover" => "discover",
    "American Express" => "american_express"
  }

  def to_s
    "#{CREDIT_CARD_TYPES.key(brand)} - #{full_name} - #{number}"
  end

  def credit_card
    @credit_card ||= ::SPREEDLY_ENVIRONMENT.find_payment_method(saved_gateway_id)
  end

  def self.create_from_spreedly_card(credit_card, token, user)
    user.credit_cards.create(
      saved_gateway_id: token,
      first_name: credit_card.first_name,
      last_name: credit_card.last_name,
      brand: credit_card.card_type,
      number: credit_card.last_four_digits,
      year: credit_card.year,
      month: credit_card.month,
      full_name: credit_card.full_name
    )
  end

end