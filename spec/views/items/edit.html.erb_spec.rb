require 'spec_helper'

describe "items/edit" do
  before(:each) do
    @item = assign(:item, stub_model(Item,
      :quantity => "MyString",
      :shop => nil,
      :max_adults => 1,
      :published => false,
      :default_price => 1.5
    ))
  end

  it "renders the edit item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", item_path(@item), "post" do
      assert_select "input#item_quantity[name=?]", "item[quantity]"
      assert_select "input#item_shop[name=?]", "item[shop]"
      assert_select "input#item_max_adults[name=?]", "item[max_adults]"
      assert_select "input#item_published[name=?]", "item[published]"
      assert_select "input#item_default_price[name=?]", "item[default_price]"
    end
  end
end
