require 'spec_helper'

describe MemberProfile do
  context "ShopOwner" do
    it "spawns a shop_request after creation" do
      shop_owner = create(:shop_owner).profile
      expect(shop_owner.shop_requests.size).to eq(1)
    end
  end
end
