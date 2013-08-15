require 'spec_helper'

describe "searches/new" do
  before(:each) do
    assign(:search, stub_model(Search,
      :keyword => "MyString",
      :adults => 1,
      :user => nil,
      :item => nil,
      :shop => nil
    ).as_new_record)
  end

  it "renders new search form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", searches_path, "post" do
      assert_select "input#search_keyword[name=?]", "search[keyword]"
      assert_select "input#search_adults[name=?]", "search[adults]"
      assert_select "input#search_user[name=?]", "search[user]"
      assert_select "input#search_item[name=?]", "search[item]"
      assert_select "input#search_shop[name=?]", "search[shop]"
    end
  end
end
