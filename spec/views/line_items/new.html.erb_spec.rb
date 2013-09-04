require 'spec_helper'

describe "line_items/new" do
  before(:each) do
    assign(:line_item, stub_model(LineItem,
      :booking => nil,
      :unit_price_at_checkout => 1.5
    ).as_new_record)
  end

  it "renders new line_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", line_items_path, "post" do
      assert_select "input#line_item_booking[name=?]", "line_item[booking]"
      assert_select "input#line_item_unit_price_at_checkout[name=?]", "line_item[unit_price_at_checkout]"
    end
  end
end
