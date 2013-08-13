require 'spec_helper'

describe "shops/edit" do
  before(:each) do
    @shop = assign(:shop, stub_model(Shop,
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
    ))
  end

  it "renders the edit shop form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", shop_path(@shop), "post" do
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
