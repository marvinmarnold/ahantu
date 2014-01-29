require 'spec_helper'

describe MemberProfile do
  context "ShopOwner" do
    it "spawns a shop_request after creation" do
      shop_owner = create(:shop_owner).profile
      expect(shop_owner.shop_requests.size).to eq(1)
    end
  end

  context "with OmniAuth" do
    context "with Facebook" do
      before(:all) do
        @response = "{\"provider\":\"facebook\",\"uid\":\"714729\",\"info\":{\"nickname\":\"maarnold\",\"email\":\"maarnold@mit.edu\",\"name\":\"Marvin Arnold\",\"first_name\":\"Marvin\",\"last_name\":\"Arnold\",\"image\":\"http://graph.facebook.com/714729/picture\",\"urls\":{\"Facebook\":\"https://www.facebook.com/maarnold\"},\"location\":\"Madrid, Spain\",\"verified\":true},\"credentials\":{\"token\":\"CAAUmOuHO2BoBAB3ea7aGBZAcDWhOiDeI5lSFiysitNCx7ep6ueZCo7phaSFr3mteKpHNHUJQ2ZCVV4YSnKXoCGTR8qCxRXOyEpYZAvc8jFZAHG9vr4HIjJUcJc484EcsMIPYa3rmS26ynIPwp0YelZATim4ZAhZBkzkdpKw8CukKDt0BXaTvi3f6\",\"expires_at\":1396203714,\"expires\":true},\"extra\":{\"raw_info\":{\"id\":\"714729\",\"name\":\"Marvin Arnold\",\"first_name\":\"Marvin\",\"last_name\":\"Arnold\",\"link\":\"https://www.facebook.com/maarnold\",\"location\":{\"id\":\"106504859386230\",\"name\":\"Madrid, Spain\"},\"education\":[{\"school\":{\"id\":\"20780862080\",\"name\":\"IE Business School\"},\"type\":\"College\"}],\"gender\":\"male\",\"email\":\"maarnold@mit.edu\",\"timezone\":1,\"locale\":\"en_US\",\"verified\":true,\"updated_time\":\"2013-11-20T19:49:16+0000\",\"username\":\"maarnold\"}}}"
        @oauth = OmniAuth::AuthHash.new JSON.parse(@response).symbolize_keys
      end

      it "creates a new user from request" do
        member_profile = MemberProfile.from_omniauth(@oauth)
        expect(member_profile.persisted?).to be_true
      end
    end
  end
end
