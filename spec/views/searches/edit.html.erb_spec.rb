require 'spec_helper'

describe "searches/edit" do
  before(:each) do
    @search = assign(:search, stub_model(Search,
      :keyword => "MyString",
      :adults => 1,
      :user => nil,
      :item => nil,
      :shop => nil
    ))
  end

  it "renders the edit search form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", search_path(@search), "post" do
      assert_select "input#search_keyword[name=?]", "search[keyword]"
      assert_select "input#search_adults[name=?]", "search[adults]"
      assert_select "input#search_user[name=?]", "search[user]"
      assert_select "input#search_item[name=?]", "search[item]"
      assert_select "input#search_shop[name=?]", "search[shop]"
    end
  end
end
