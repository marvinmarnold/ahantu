require 'spec_helper'

describe "shops/index" do
  before(:each) do
    assign(:shops, [
      stub_model(Shop,
        :user => nil,
        :city => nil,
        :published => false,
        :logo => "Logo",
        :address1 => "Address1",
        :address2 => "Address2",
        :directions => "MyText",
        :website1 => "Website1",
        :website2 => "Website2",
        :website3 => "Website3",
        :website4 => "Website4",
        :website5 => "Website5"
      ),
      stub_model(Shop,
        :user => nil,
        :city => nil,
        :published => false,
        :logo => "Logo",
        :address1 => "Address1",
        :address2 => "Address2",
        :directions => "MyText",
        :website1 => "Website1",
        :website2 => "Website2",
        :website3 => "Website3",
        :website4 => "Website4",
        :website5 => "Website5"
      )
    ])
  end

  it "renders a list of shops" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Logo".to_s, :count => 2
    assert_select "tr>td", :text => "Address1".to_s, :count => 2
    assert_select "tr>td", :text => "Address2".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Website1".to_s, :count => 2
    assert_select "tr>td", :text => "Website2".to_s, :count => 2
    assert_select "tr>td", :text => "Website3".to_s, :count => 2
    assert_select "tr>td", :text => "Website4".to_s, :count => 2
    assert_select "tr>td", :text => "Website5".to_s, :count => 2
  end
end
