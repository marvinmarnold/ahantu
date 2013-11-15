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

    def create_default_accounts
      create_profile("maarnold@alum.mit.edu", "shopper")
      create_profile("marvinmarnold@gmail.com", "salesperson")
      create_profile("marvin@ahantu.com", "shop_owner")

      # create_profile("shopper@ahantu.com", "shopper")
      # create_profile("salesperson@ahantu.com", "salesperson")
      # create_profile("shop_owner@ahantu.com", "shop_owner")
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
        preload_rooms_for_hotel sample_hotel, samples_path
      end
    end

    def create_hotel_from_general_info(hotel_root_path)
      general_info_csv_path = "#{hotel_root_path}/general/info.csv"

      puts "Reading hotel #{general_info_csv_path}"
      r = CSV.read(general_info_csv_path, headers: false, encoding: "UTF-8", col_sep: ",", row_sep: "\n")

      sample_hotel = create_hotel_from_arr r, hotel_root_path
      add_descriptions_to_describable_from_arr sample_hotel, r
      add_tags_to_taggable_from_arr sample_hotel, r
      add_photos_to_photoable sample_hotel, "#{hotel_root_path}/general"

      sample_hotel
    end

    def create_hotel_from_arr(r, root_path)
      pic_path = "#{root_path}/general/main.jpg"
      hotel_params ={
        address1: get_v(r[8]),
        address2: get_v(r[9]),
        location: Location.find_by_name(get_v(r[10])),
        directions: get_v(r[11]),
        website1: get_v(r[12]),
        website2: get_v(r[13]),
        website3: get_v(r[14]),
        logo: File.open(pic_path),
        commission_pct: 0.1,
        user: MemberProfile.where(role: "shop_owner").first.user,
        published: true
      }

      Shop.create!(hotel_params)
    end

    #MAKE SURE DESCRIPTIONS ROWS 2-5
    def add_descriptions_to_describable_from_arr(describable, r)
      describable.descriptions.create!(
        language: Language.find_by_abbr(:en),
        name: get_v(r[2]),
        description: get_v(r[3])
      )

      describable.descriptions.create!(
        language: Language.find_by_abbr(:fr),
        name: get_v(r[4]),
        description: get_v(r[5])
      )
    end

    def add_tags_to_taggable_from_arr(taggable, r)
      tag_klass = nil
      r.each do |row|
        if get_l(row).try(:match, "^Tag")
          tag_klass = get_l(row)
        end

        if tag_klass.present? && get_v(row).present?
          tag = tag_klass.constantize.joins(:descriptions).where("descriptions.name ilike :k", {k: get_l(row)}).first
          Tagging.create(tag: tag, taggable: taggable)
        end
      end
    end

    def get_v(r)
      r[2]
    end

    def get_l(r)
      r[1]
    end

    def preload_rooms_for_hotel(hotel, hotel_root_path)
      Dir[Rails.root.join("#{hotel_root_path}/rooms/*")].each do |room_path|
        puts "Reading room #{room_path}/info.csv"
        r = CSV.read("#{room_path}/info.csv", headers: false, encoding: "UTF-8", col_sep: ",", row_sep: "\n")
        sample_room = create_room_from_arr hotel, r
        add_descriptions_to_describable_from_arr sample_room, r
        add_tags_to_taggable_from_arr sample_room, r
        add_photos_to_photoable sample_room, room_path
      end
    end

    def create_room_from_arr(hotel, r)
      room_params ={
        quantity: get_v(r[8]),
        default_price: get_v(r[9]),
        max_adults: get_v(r[10]),
        published: true
      }

      hotel.items.create!(room_params)
    end

    #nasty dependencies on parallel locations
    def add_photos_to_photoable(photoable, root_path)
      Dir.glob("#{root_path}/photos/*") do |pic_path|
        photo_params = { photoable: photoable }
        if Rails.env.development?
          photo_params["photo"] = File.open(pic_path)
        else
          s3_url = "http://ahantuhotelsamples.s3.amazonaws.com/"
          remote_pic_path = s3_url + pic_path.gsub("/home/pili/workspace/ahantu/vendor/hotels/sample/","")
          photo_params["remote_photo_url"] = remote_pic_path
        end
        Photo.create! photo_params
        # puts "Photo uploaded: #{photo_params}"
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
        "Parking",
        "Camping"
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

  end
end