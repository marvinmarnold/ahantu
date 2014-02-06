require 'spec_helper'

describe CreditCard do
  context "submitted cart" do
    before(:each) do
      @card = create(:credit_card)
    end

    it "stores credit card" do
      last_four = @card.number[-4,4]
      @card.store

      expect(@card.number).to eq last_four
      expect(@card.cvv).to eq nil
      expect(@card.saved_gateway_id).to be_a(String)
    end

  end

  it "upcases names before saving" do
    first_name = "mY"
    last_name = "somethiNg"
    card = create(:credit_card, first_name: first_name, last_name: last_name)
    expect(card.first_name).to eq first_name.upcase
    expect(card.last_name).to eq last_name.upcase
  end

  it "separates first and last name" do
    name = "Marvin Merlen Michael Arnold"
    card = create(:credit_card, name_on_card: name,first_name: nil, last_name: nil)
    expect(card.first_name).to eq "Marvin Merlen Michael".upcase
    expect(card.last_name).to eq "Arnold".upcase
  end
end