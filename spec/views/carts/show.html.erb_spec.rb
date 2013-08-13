require 'spec_helper'

describe "carts/show" do
  before(:each) do
    @cart = assign(:cart, stub_model(Cart,
      :user => nil,
      :shop => nil,
      :total_at_checkout => 1.5,
      :payment_amount => 1.5,
      :billing_inform => "Billing Inform"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/Billing Inform/)
  end
end
