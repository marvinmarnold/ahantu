module BillingInformationsHelper
  def credit_card_types
    CreditCard::CREDIT_CARD_TYPES
  end

  def credit_card_expiration(credit_card)
    DateTime.new(credit_card.year, credit_card.month, 1).strftime("%m/%y")
  end
end
