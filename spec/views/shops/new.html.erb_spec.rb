require 'spec_helper'

describe "shops/new" do
  before(:each) do
    assign(:shop, stub_model(Shop,
      :user => nil,
      :city => nil,
      :published => false,
      :logo => "MyString",
      :address1 => "MyString",
      :address2 => "MyString",
      :directions => "MyText",
      :website1 => "MyString",
      :website2 => "MyString",
      :website3 => "MyString",
      :website4 => "MyString",
      :website5 => "MyString"
    ).as_new_record)
  end

  it "renders new shop form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", shops_path, "post" do
      assert_select "input#shop_user[name=?]", "shop[user]"
      assert_select "input#shop_city[name=?]", "shop[city]"
      assert_select "input#shop_published[name=?]", "shop[published]"
      assert_select "input#shop_logo[name=?]", "shop[logo]"
      assert_select "input#shop_address1[name=?]", "shop[address1]"
      assert_select "input#shop_address2[name=?]", "shop[address2]"
      assert_select "textarea#shop_directions[name=?]", "shop[directions]"
      assert_select "input#shop_website1[name=?]", "shop[website1]"
      assert_select "input#shop_website2[name=?]", "shop[website2]"
      assert_select "input#shop_website3[name=?]", "shop[website3]"
      assert_select "input#shop_website4[name=?]", "shop[website4]"
      assert_select "input#shop_website5[name=?]", "shop[website5]"
    end
  end
end
