require 'spec_helper'

describe "contacts/new" do
  before(:each) do
    assign(:contact, stub_model(Contact,
      :type => "",
      :user => nil,
      :value => "MyString"
    ).as_new_record)
  end

  it "renders new contact form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", contacts_path, "post" do
      assert_select "input#contact_type[name=?]", "contact[type]"
      assert_select "input#contact_user[name=?]", "contact[user]"
      assert_select "input#contact_value[name=?]", "contact[value]"
    end
  end
end
