module TagsHelper
	def search_tag_id(tag)
    "search_tag_ids_#{tag.id}"
  end

  def search_tag_name
  	"search[tag_ids][]"
  end

  # Order important. Eventually will be more dynamic
  def hotel_tag_categories_search
    [
      Tag::HotelTag::FacilityTag,
      Tag::HotelTag::InternetTag,
      Tag::HotelTag::ServiceTag,
      # Tag::HotelTag::LanguageTag
    ]
  end

  def hotel_tag_categories_show
    [
      Tag::HotelTag::FacilityTag,
      Tag::HotelTag::InternetTag,
      Tag::HotelTag::ServiceTag,
      Tag::HotelTag::LanguageTag
    ]
  end

  def room_tag_categories
    [
      Tag::RoomTag::FacilityTag,
      Tag::RoomTag::InternetTag,
      Tag::RoomTag::FoodDrinkTag,
      Tag::RoomTag::ServiceTag,
      Tag::RoomTag::ParkingTag,
      Tag::RoomTag::ViewTag
    ]
  end

  def label_for_tag_category(klass)
    {
      # Hotel tags
      "Tag::HotelTag::FacilityTag" => I18n.t("tag.category_names.hotel_tag.facility_tag"),
      "Tag::HotelTag::InternetTag" => I18n.t("tag.category_names.hotel_tag.internet_tag"),
      "Tag::HotelTag::ServiceTag" => I18n.t("tag.category_names.hotel_tag.service_tag"),
      "Tag::HotelTag::LanguageTag" => I18n.t("tag.category_names.hotel_tag.language_tag"),
      # Room tags
      "Tag::RoomTag::FacilityTag" => I18n.t("tag.category_names.room_tag.facility_tag"),
      "Tag::RoomTag::FoodDrinkTag" => I18n.t("tag.category_names.room_tag.food_drink_tag"),
      "Tag::RoomTag::InternetTag" => I18n.t("tag.category_names.room_tag.internet_tag"),
      "Tag::RoomTag::ParkingTag" => I18n.t("tag.category_names.room_tag.parking_tag"),
      "Tag::RoomTag::ServiceTag" => I18n.t("tag.category_names.room_tag.service_tag"),
      "Tag::RoomTag::ViewTag" => I18n.t("tag.category_names.room_tag.view_tag"),
    }[klass.to_s]
  end
end
