require 'spec_helper'

describe "confirmations/show" do
  before(:each) do
    @confirmation = assign(:confirmation, stub_model(Confirmation,
      :message => "Message",
      :type => "Type",
      :text => "MyText",
      :booking => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Message/)
    rendered.should match(/Type/)
    rendered.should match(/MyText/)
    rendered.should match(//)
  end
end
