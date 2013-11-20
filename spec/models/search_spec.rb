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
    @item = create(:complete_item, shop: @shop, quantity: 1, max_adults: 1)
    @b1 = create(:booking, item: @item, cart: create(:cart), adults: @item.max_adults)
    @item.quantity.times { create(:line_item, booking: @b1, booking_at: Date.today) }

    @s1 = create(:search, shop: @shop, checkin_at: Date.today, checkout_at: Date.tomorrow)
    create(:room_search, adults: @item.max_adults, search: @s1)

    @s2 = create(:search, shop: @shop, checkin_at: Date.tomorrow, checkout_at: 4.days.from_now)
    create(:room_search, adults: @item.max_adults, search: @s2)

    expect(@s1.filtered_by_availability).to eq []
    expect(@s2.filtered_by_availability).to eq [@shop]

    @item = create(:complete_item, shop: @shop, quantity: 1, max_adults: 2)
    expect(@s1.filtered_by_availability).to eq [@shop]
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
