require 'csv'

module Seeder
  class << self
    @password = "password"
    def gen_locations(filename="vendor/rwanda.csv")
      last_at_depth = {}
      CSV.foreach(Rails.root.join("#{filename}"), headers: false, encoding: "UTF-8", col_sep: ";", row_sep: "\n") do |row|
        depth = row.size
        last_at_depth[depth] =  Location.create!(name: row[depth-1], parent: parent_node(depth, last_at_depth))
      end
    end

    def parent_node(depth, last_at_depth)
      (parent = last_at_depth[depth - 1]).blank? ? nil : parent
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
        "Heated rooms",
        "Television",
        "Interior office space",
        "Telephone"
      ], Tag::RoomTag::FacilityTag
    end

    def create_room_food_drink_tags
      create_tags [
        "Breakfast included",
        "Refrigerator",
        "Room service",
        "Kitchen in room",
        "Barbeque/brai access",
        "Minibar"
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

    def preload_hotels
      path_to_sample_csvs = "vendor/hotels/sample"
      Dir[Rails.root.join("#{path_to_sample_csvs}/*")].each do |samples_path|
        sample_hotel = create_hotel_from_general_info samples_path
        # preload_rooms_for_hotel sample_hotel, samples_path
      end
    end

    def create_hotel_from_general_info(hotel_root_path)
      general_info_csv_path = "#{hotel_root_path}/general/info.csv"

      r = CSV.read(general_info_csv_path, headers: false, encoding: "UTF-8", col_sep: ",", row_sep: "\n")

      sample_hotel = create_hotel_from_arr r
      add_descriptions_to_sample_hotel_from_arr sample_hotel, r
      add_tags_to_sample_hotel_from_arr sample_hotel, r

      sample_hotel
    end

    def create_hotel_from_arr(r)
      hotel_params ={
        address1: get_v(r[8]),
        address2: get_v(r[9]),
        location: Location.find_by_name(get_v(r[10])),
        directions: get_v(r[11]),
        website1: get_v(r[12]),
        website2: get_v(r[13]),
        website3: get_v(r[14]),
        commission_pct: 0.1,
        user: MemberProfile.where(role: "shop_owner").first.user,
        published: true
      }

      Shop.create!(hotel_params)
    end

    def add_descriptions_to_sample_hotel_from_arr(sample_hotel, r)

      sample_hotel.descriptions.create!(
        language: Language.find_by_abbr(:en),
        name: get_v(r[2]),
        description: get_v(r[3])
      )

      sample_hotel.descriptions.create!(
        language: Language.find_by_abbr(:fr),
        name: get_v(r[4]),
        description: get_v(r[5])
      )
    end

    def add_tags_to_sample_hotel_from_arr(sample_hotel, r)
      tag_klass = nil
      r.each do |row|
        tag_klass = get_v(row).try(:match, "^Tag")

        unless tag_klass.blank?
          new_tag = sample_hotel.tags.create!
          new_tag.descriptions.create(
            type: tag_klass,
            language_id: Language.find_by_abbr(:en),
            name: get_v(row)
          )
        end
      end
    end

    def get_v(r)
      r[2]
    end

    def preload_rooms_for_hotel(hotel_root_path)

    end

  end
end

      # CSV.foreach(path_to_csv,
      #   headers: true,
      #   encoding: "UTF-8",
      #   col_sep: ",",
      #   row_sep: "\n")
      # do |row_vals|
      #   number = clean_phone_number(row_vals[0])
      #   c = CellPhone.find_or_create_by_value!(number)
      #   first_name, middle_names, last_name = split_names row_vals[1]
      #   p = c.participant
      # end