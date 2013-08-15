require 'spec_helper'

describe "descriptions/show" do
  before(:each) do
    @description = assign(:description, stub_model(Description,
      :language => nil,
      :name => "Name",
      :description => "MyText",
      :describable => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(//)
  end
end
