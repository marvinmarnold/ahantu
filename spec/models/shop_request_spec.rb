require 'spec_helper'
describe ShopRequest do

  it "assigns a profile to a request", focus: true do
    @shop_request = create(:shop_request)
    @salesperson = create(:salesperson)
    @shop_request.assign_to @salesperson
    expect(@shop_request.salesperson).to eq @salesperson
  end
end
