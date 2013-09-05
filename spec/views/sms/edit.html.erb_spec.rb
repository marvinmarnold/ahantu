require 'spec_helper'

describe "sms/edit" do
  before(:each) do
    @sm = assign(:sm, stub_model(Sm,
      :cart => nil,
      :message => "MyText",
      :phone => nil,
      :incoming => false
    ))
  end

  it "renders the edit sm form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", sm_path(@sm), "post" do
      assert_select "input#sm_cart[name=?]", "sm[cart]"
      assert_select "textarea#sm_message[name=?]", "sm[message]"
      assert_select "input#sm_phone[name=?]", "sm[phone]"
      assert_select "input#sm_incoming[name=?]", "sm[incoming]"
    end
  end
end
