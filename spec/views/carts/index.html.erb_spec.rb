require 'spec_helper'

describe "carts/index" do
  before(:each) do
    assign(:carts, [
      stub_model(Cart,
        :user => nil,
        :shop => nil,
        :total_at_checkout => 1.5,
        :payment_amount => 1.5,
        :billing_inform => "Billing Inform"
      ),
      stub_model(Cart,
        :user => nil,
        :shop => nil,
        :total_at_checkout => 1.5,
        :payment_amount => 1.5,
        :billing_inform => "Billing Inform"
      )
    ])
  end

  it "renders a list of carts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Billing Inform".to_s, :count => 2
  end
end
