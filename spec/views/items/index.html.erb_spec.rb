require 'spec_helper'

describe "items/index" do
  before(:each) do
    assign(:items, [
      stub_model(Item,
        :quantity => "Quantity",
        :shop => nil,
        :max_adults => 1,
        :published => false,
        :default_price => 1.5
      ),
      stub_model(Item,
        :quantity => "Quantity",
        :shop => nil,
        :max_adults => 1,
        :published => false,
        :default_price => 1.5
      )
    ])
  end

  it "renders a list of items" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Quantity".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
