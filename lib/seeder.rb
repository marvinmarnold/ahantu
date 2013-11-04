require 'csv'

module Seeder
  class << self
    @password = "password"
    def gen_locations(filename)
      old_country = nil
      old_province = nil
      i = 2

      CSV.foreach(filename, :col_sep => "\t", headers: false) do |row|
        row = row[0].strip
        if country = country?(row)
          country = country[i].strip
          old_country = "something"
          # old_country = Country.create!(name: country)
          # puts "Created country #{country}"
        elsif old_country && province = province?(row)
          province = province[i].strip
          old_province = Province.create!(name: province)
          # puts "Created province #{province}"#{}} (#{old_country.id})"
        elsif old_province && district = district?(row)
          district = district[i].strip
          City.create!(name: district, province: old_province)
          # puts "Created district #{district} (#{old_province.id})"
        else
          puts "Did not know what to do with #{row}"
        end
      end
    end

    def country?(text)
      text.match /\ACOUNTRY( de )?(.+)\z/i
    end

    def district?(text)
      text.match /\ADistrito( de )?(.+)\z/i
    end

    def province?(text)
      text.match /\AProvincia( de )?(.+)\z/i
    end

    def add_descriptions(describable, h)
      h["descriptions"].each do |lang, description_yaml|
        description_yaml.merge!({
          language_id: Language.find_by_abbr(lang).id
        })
        describable.descriptions.create!(description_yaml)
      end
    end

    def add_photos(photoable, h)
      Dir.glob("#{h[:photos.to_s]}/*") do |pic_path|
        Photo.create!(
          photoable: photoable,
          image: File.open(pic_path),
        )
      end
    end

    def create_hotel_tags
      create_hotel_language_tags
      create_hotel_facility_tags
      create_hotel_internet_tags
      create_hotel_service_tags
    end

    def create_hotel_facility_tags
      create_tags [
        "Swimming pool",
        "Gym",
        "Meeting rooms/banquet hall",
        "Elevator",
        "Eco-friendly",
        "Handicapped accessible",
        "Hot water",
        "Bar",
        "Restaurant",
        "Self catering",
        "Pet friendly",
        "Parking"
      ], Tag::HotelTag::FacilityTag
    end

    def create_hotel_internet_tags
      create_tags [
        "Wifi available"
      ], Tag::HotelTag::InternetTag
    end

    def create_hotel_service_tags
      create_tags [
        "24-hour front desk",
        "Laundry",
        "Room service",
        "Currency exchange",
        "Printing",
        "Baggage storage"
      ], Tag::HotelTag::ServiceTag
    end

    def create_hotel_language_tags
      create_tags [
        "Italian",
        "French",
        "Spanish",
        "English",
        "German",
        "Kinyarwanda",
        "Swahili",
        "Arabic",
        "Portuguese",
        "Swedish",
        "Dutch",
      ], Tag::HotelTag::LanguageTag
    end

    def create_room_tags
      create_room_facility_tags
      create_room_food_drink_tags
      create_room_view_tags
      create_room_internet_tags
      create_room_parking_tags
    end

    def create_room_facility_tags
      create_tags [
        "Personal safe",
        "Interior bathroom",
        "Hot water",
        "Handicapped accessible",
        "Air conditioned",
        "Heated rooms"
      ], Tag::RoomTag::FacilityTag
    end

    def create_room_food_drink_tags
      create_tags [
        "Breakfast included",
        "Refrigerator",
        "Room service",
        "Kitchen in room",
        "Barbeque/brai access"
      ], Tag::RoomTag::FoodDrinkTag
    end

    def create_room_view_tags
      create_tags [
        "Terrace",
        "Street view",
        "Beach view",
        "Nature view",
        "City view"
      ], Tag::RoomTag::ViewTag
    end

    def create_room_internet_tags
      create_tags [
       "Free wifi",
       "Paid wifi",
       "No wifi"
      ], Tag::RoomTag::InternetTag
    end

    def create_room_parking_tags
      create_tags [
        "Free parking",
        "No parking",
        "Paid parking"
      ], Tag::RoomTag::ParkingTag
    end

    def create_tags(tag_list, tag_class)
      tag_list.each do |t|
        tag = tag_class.create
        tag.descriptions.create(language_id: Language.default.id, name: t) end
    end

    def create_default_accounts
      # create_profile("marvin@ahantu.com", "admin")
      # create_profile("marvinmarnold@gmail.com", "salesperson")
      # create_profile("maarnold@alum.mit.edu", "shopper")
      create_profile("shopper@ahantu.com", "shopper")
      create_profile("salesperson@ahantu.com", "salesperson")
      create_profile("shop_owner@ahantu.com", "shop_owner")
    end

    def create_profile(email, role)
      password = "password"
      puts "Creating: #{email}, #{role}"

      u = User.new
      u.profile = MemberProfile.create!(
          :role => role,
          :email => email,
          :password => password,
          :password_confirmation => password
      )
      u.save!

      u
    end

  end
end
