require 'spec_helper'

describe "line_items/edit" do
  before(:each) do
    @line_item = assign(:line_item, stub_model(LineItem,
      :booking => nil,
      :unit_price_at_checkout => 1.5
    ))
  end

  it "renders the edit line_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", line_item_path(@line_item), "post" do
      assert_select "input#line_item_booking[name=?]", "line_item[booking]"
      assert_select "input#line_item_unit_price_at_checkout[name=?]", "line_item[unit_price_at_checkout]"
    end
  end
end
