require 'spec_helper'

describe "sms/new" do
  before(:each) do
    assign(:sm, stub_model(Sm,
      :cart => nil,
      :message => "MyText",
      :phone => nil,
      :incoming => false
    ).as_new_record)
  end

  it "renders new sm form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", sms_path, "post" do
      assert_select "input#sm_cart[name=?]", "sm[cart]"
      assert_select "textarea#sm_message[name=?]", "sm[message]"
      assert_select "input#sm_phone[name=?]", "sm[phone]"
      assert_select "input#sm_incoming[name=?]", "sm[incoming]"
    end
  end
end
