require 'spec_helper'

describe "descriptions/edit" do
  before(:each) do
    @description = assign(:description, stub_model(Description,
      :language => nil,
      :name => "MyString",
      :description => "MyText",
      :describable => nil
    ))
  end

  it "renders the edit description form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", description_path(@description), "post" do
      assert_select "input#description_language[name=?]", "description[language]"
      assert_select "input#description_name[name=?]", "description[name]"
      assert_select "textarea#description_description[name=?]", "description[description]"
      assert_select "input#description_describable[name=?]", "description[describable]"
    end
  end
end
