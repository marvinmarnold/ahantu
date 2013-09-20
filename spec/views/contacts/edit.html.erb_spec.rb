require 'spec_helper'

describe "contacts/edit" do
  before(:each) do
    @contact = assign(:contact, stub_model(Contact,
      :type => "",
      :user => nil,
      :value => "MyString"
    ))
  end

  it "renders the edit contact form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", contact_path(@contact), "post" do
      assert_select "input#contact_type[name=?]", "contact[type]"
      assert_select "input#contact_user[name=?]", "contact[user]"
      assert_select "input#contact_value[name=?]", "contact[value]"
    end
  end
end
