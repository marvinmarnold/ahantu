require 'spec_helper'

describe "carts/edit" do
  before(:each) do
    @cart = assign(:cart, stub_model(Cart,
      :user => nil,
      :shop => nil,
      :total_at_checkout => 1.5,
      :payment_amount => 1.5,
      :billing_inform => "MyString"
    ))
  end

  it "renders the edit cart form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", cart_path(@cart), "post" do
      assert_select "input#cart_user[name=?]", "cart[user]"
      assert_select "input#cart_shop[name=?]", "cart[shop]"
      assert_select "input#cart_total_at_checkout[name=?]", "cart[total_at_checkout]"
      assert_select "input#cart_payment_amount[name=?]", "cart[payment_amount]"
      assert_select "input#cart_billing_inform[name=?]", "cart[billing_inform]"
    end
  end
end
