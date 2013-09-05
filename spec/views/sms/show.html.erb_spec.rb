require 'spec_helper'

describe "sms/show" do
  before(:each) do
    @sm = assign(:sm, stub_model(Sm,
      :cart => nil,
      :message => "MyText",
      :phone => nil,
      :incoming => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/MyText/)
    rendered.should match(//)
    rendered.should match(/false/)
  end
end
