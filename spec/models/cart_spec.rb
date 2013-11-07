require 'spec_helper'

describe Cart do
  context "submitted cart" do
    before(:all) do
      Language.create(name: "English", abbr: :en)
      # binding.pry
      @cart = create(:cart_submitted)
    end

    it "confirms order with correct order number" do
      confirmation_code = @cart.receive_confirmation(create(:email_confirmation, message: @cart.order_number))
      expect(confirmation_code).to eq :confirmed
    end
  end

  it "authorizes payments through paypal", focus: true do
    @cart = create(:cart_ready_to_authorize)
    expect(@cart.send(:submit_payment_authorization)).to be_true
  end
end
