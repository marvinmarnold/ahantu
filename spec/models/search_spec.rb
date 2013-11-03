require 'spec_helper'

describe Search do
  context "searching by filter" do
    before(:each) do
      @search = create(:search)
      @shop = create(:shop, published: true)
    end

    it "returns all published shops when no tags applied to shops" do
      expect(@search.filtered_by_hotel_tags).to eq(Shop.published)
    end

    it "returns all shops with at least the same tags as applied to search" do
      @shop2 = create(:shop, published: true)
      tag1 = create(:hotel_tag)
      tag2 = create(:hotel_tag)
      create(:tagging, taggable: @search, tag: tag1)
      create(:tagging, taggable: @shop, tag: tag1)
      create(:tagging, taggable: @shop2, tag: tag1)
      create(:tagging, taggable: @shop2, tag: tag2)

      expect(@search.filtered_by_hotel_tags).to eq([@shop, @shop2])
    end
  end
end
