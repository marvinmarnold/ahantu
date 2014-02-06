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
end