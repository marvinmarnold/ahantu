require 'spec_helper'

describe "bookings/show" do
  before(:each) do
    @booking = assign(:booking, stub_model(Booking,
      :cart => nil,
      :item => nil,
      :responsible_first_name => "Responsible First Name",
      :responsible_last_name => "Responsible Last Name",
      :adults => 1,
      :name_at_checkout => "Name At Checkout",
      :quantity => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Responsible First Name/)
    rendered.should match(/Responsible Last Name/)
    rendered.should match(/1/)
    rendered.should match(/Name At Checkout/)
    rendered.should match(/2/)
  end
end
