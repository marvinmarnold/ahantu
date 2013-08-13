require 'spec_helper'

describe "shops/show" do
  before(:each) do
    @shop = assign(:shop, stub_model(Shop,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/false/)
    rendered.should match(/Logo/)
    rendered.should match(/Address1/)
    rendered.should match(/Address2/)
    rendered.should match(/MyText/)
    rendered.should match(/Website1/)
    rendered.should match(/Website2/)
    rendered.should match(/Website3/)
    rendered.should match(/Website4/)
    rendered.should match(/Website5/)
  end
end
