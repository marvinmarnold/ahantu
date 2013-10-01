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
          puts "Created country #{country}"
        elsif old_country && province = province?(row)
          province = province[i].strip
          old_province = Province.create!(name: province)
          puts "Created province #{province}"#{}} (#{old_country.id})"
        elsif old_province && district = district?(row)
          district = district[i].strip
          City.create!(name: district, province: old_province)
          puts "Created district #{district} (#{old_province.id})"
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
      [
        "Swimming Pool",
        "Wifi",
        "Gym",
        "Bed and Breakfast",
        "Meeting Facilities",
        "Pet Friendly",
        "Restaurant",
        "Self Catering",
        "Eco-friendly",
        "Handicapped accessible",
        "Hot showers",
        "Bar",
      ].each do |t|
        h = HotelTag.create
        h.descriptions.create(language_id: Language.default.id, name: t)
      end
    end

    def create_room_tags
      [
          "Free Wifi",
          "Breakfast Included",
          "Non-refundable",
          "Secure safe",
          "Bathroom",
          "Air conditioner",
          "Parking"
      ].each do |t|
        RoomTag.create!(name: t)
      end
    end

    def create_default_accounts
      # {
      #     "salesperson" => SalespersonProfile,
      #     "shopper" => ShopperProfile,
      # }.each do |e, profile_type|
      #   create_profile("#{e}@#{ENV["DOMAIN"]}", profile_type)
      # end
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
