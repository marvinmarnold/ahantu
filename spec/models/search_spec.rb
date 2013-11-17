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

  it "only returns shops with available items" do
    @shop = create(:complete_shop)
    @item = create(:complete_item, shop: @shop)
    @booking = create(:booking, item: @item, cart: create(:cart), adults: @item.max_adults)
    @item.quantity.times { create(:line_item, booking: @booking, booking_at: Date.today) }
    @search = create(:search, shop: @shop)
    create(:room_search, adults: @item.max_adults, search: @search)

    expect(@search.filtered_by_availability).to eq Shop.none
  end

  it "only returns shop if shop_id set" do
    @shop = create(:shop, published: true)
    @search = create(:search, shop: @shop)

    expect(@search.filtered_by_shop).to eq([@shop])
  end

  it "returns num of nights from checkin to checkout" do
    checkin = Date.today
    checkout = checkin + 1.weeks
    @search = create(:search, checkin_at: checkin, checkout_at: checkout)
    expect(@search.nights).to eq (checkin..(checkout-1.day))
  end
end
