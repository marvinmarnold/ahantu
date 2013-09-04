require 'spec_helper'

describe "bookings/new" do
  before(:each) do
    assign(:booking, stub_model(Booking,
      :cart => nil,
      :item => nil,
      :responsible_first_name => "MyString",
      :responsible_last_name => "MyString",
      :adults => 1,
      :name_at_checkout => "MyString",
      :quantity => 1
    ).as_new_record)
  end

  it "renders new booking form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", bookings_path, "post" do
      assert_select "input#booking_cart[name=?]", "booking[cart]"
      assert_select "input#booking_item[name=?]", "booking[item]"
      assert_select "input#booking_responsible_first_name[name=?]", "booking[responsible_first_name]"
      assert_select "input#booking_responsible_last_name[name=?]", "booking[responsible_last_name]"
      assert_select "input#booking_adults[name=?]", "booking[adults]"
      assert_select "input#booking_name_at_checkout[name=?]", "booking[name_at_checkout]"
      assert_select "input#booking_quantity[name=?]", "booking[quantity]"
    end
  end
end
