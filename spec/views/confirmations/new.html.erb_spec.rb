require 'spec_helper'

describe "confirmations/new" do
  before(:each) do
    assign(:confirmation, stub_model(Confirmation,
      :message => "MyString",
      :type => "",
      :text => "MyText",
      :booking => nil
    ).as_new_record)
  end

  it "renders new confirmation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", confirmations_path, "post" do
      assert_select "input#confirmation_message[name=?]", "confirmation[message]"
      assert_select "input#confirmation_type[name=?]", "confirmation[type]"
      assert_select "textarea#confirmation_text[name=?]", "confirmation[text]"
      assert_select "input#confirmation_booking[name=?]", "confirmation[booking]"
    end
  end
end
