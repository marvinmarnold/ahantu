require 'spec_helper'
describe User do

  it "creates a search with default number of room_searches" do
    guest = build(:user)
    shop = guest.new_search
    expect(shop.room_searches.size).to eq guest.suggested_num_room_searches
    expect(shop.room_searches.sample.adults).to eq guest.suggested_room_search_adults
  end
end
