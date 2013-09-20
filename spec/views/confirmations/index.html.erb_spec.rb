require 'spec_helper'

describe "confirmations/index" do
  before(:each) do
    assign(:confirmations, [
      stub_model(Confirmation,
        :message => "Message",
        :type => "Type",
        :text => "MyText",
        :booking => nil
      ),
      stub_model(Confirmation,
        :message => "Message",
        :type => "Type",
        :text => "MyText",
        :booking => nil
      )
    ])
  end

  it "renders a list of confirmations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Message".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
