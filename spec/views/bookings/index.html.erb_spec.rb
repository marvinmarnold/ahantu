require 'spec_helper'

describe "bookings/index" do
  before(:each) do
    assign(:bookings, [
      stub_model(Booking,
        :cart => nil,
        :item => nil,
        :responsible_first_name => "Responsible First Name",
        :responsible_last_name => "Responsible Last Name",
        :adults => 1,
        :name_at_checkout => "Name At Checkout",
        :quantity => 2
      ),
      stub_model(Booking,
        :cart => nil,
        :item => nil,
        :responsible_first_name => "Responsible First Name",
        :responsible_last_name => "Responsible Last Name",
        :adults => 1,
        :name_at_checkout => "Name At Checkout",
        :quantity => 2
      )
    ])
  end

  it "renders a list of bookings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Responsible First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Responsible Last Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name At Checkout".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
