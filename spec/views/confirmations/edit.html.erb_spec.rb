require 'spec_helper'

describe "confirmations/edit" do
  before(:each) do
    @confirmation = assign(:confirmation, stub_model(Confirmation,
      :message => "MyString",
      :type => "",
      :text => "MyText",
      :booking => nil
    ))
  end

  it "renders the edit confirmation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", confirmation_path(@confirmation), "post" do
      assert_select "input#confirmation_message[name=?]", "confirmation[message]"
      assert_select "input#confirmation_type[name=?]", "confirmation[type]"
      assert_select "textarea#confirmation_text[name=?]", "confirmation[text]"
      assert_select "input#confirmation_booking[name=?]", "confirmation[booking]"
    end
  end
end
