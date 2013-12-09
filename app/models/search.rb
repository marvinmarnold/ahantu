class Search < ActiveRecord::Base
  belongs_to :user, inverse_of: :searches
  belongs_to :shop
  has_many :taggings, as: :taggable
  has_many :hotel_tags, through: :taggings, class_name: "Tag::HotelTag", source: :tag
  has_many :room_searches, :dependent => :destroy
  has_one :cart
  scope   :submitted, lambda { joins(:cart) }

  accepts_nested_attributes_for :room_searches, allow_destroy: true

  validate :future_check_in, :later_check_out
  validates :keyword, :checkin_at, :checkout_at, :user_id,
    presence: true

  def self.active(searches)
    q = searches
    submitted.each do |s|
      q.where.not(id: s.id)
    end
    q.where("created_at > ?", 1.week.ago)
  end

  def results(filtered_shops = Shop.published)
    filtered_shops = filtered_by_shop(filtered_shops)
    filtered_shops = filtered_by_keyword(filtered_shops)
    filtered_shops = filtered_by_hotel_tags(filtered_shops)
    filtered_shops = filtered_by_availability(filtered_shops)

    filtered_shops.uniq
  end

  def filtered_by_availability(filtered_shops = Shop.published)
    filtered_shops.each do |filtered_shop|
      filtered_shops = filtered_shops.where.not(id: filtered_shop.id) unless shop_available?(filtered_shop)
    end

    filtered_shops
  end

  def filtered_by_shop(filtered_shops = Shop.published)
    filtered_shops = filtered_shops.where(id: shop.id) if shop.present?

    filtered_shops
  end

  def filtered_by_keyword(filtered_shops = Shop.published)
    if self.keyword.present?
      k = "%#{self.keyword}%"
      filtered_shops = filtered_shops.joins(:location).joins(:descriptions).
        where("descriptions.name ilike :k or locations.name ilike :k",
        { k: k })
    end

    filtered_shops
  end

  def filtered_by_hotel_tags(filtered_shops = Shop.published)
    if self.hotel_tags.present?
      filtered_shops.each do |s|
        filtered_shops = filtered_shops.not_shop(s) unless tags_match?(s)
      end
    end

    filtered_shops
  end

  def shop_available?(_shop)
    nights.each do |night|
      if !shop_available_on_date?(_shop, night)
        return false
      end
    end

    true
  end

  def shop_available_on_date?(_shop, date)
    room_carry_over = 0

    #sort demand from highest num_adults to smallest
    room_demand.to_a.sort { |x,y| y[0] <=> x[0] }.each do |_adults, demand|
      extra_rooms = _shop.num_available_items(date, _adults) - demand
      room_carry_over += extra_rooms
      if room_carry_over < 0
        return false
      end
    end
  end

  # { num adults => num needed }
  def room_demand
    room_searches.each_with_object(Hash.new(0)) do |room_search, h|
      h[room_search.adults] += 1
    end
  end

  def has_hotel_tag?(tag)
    hotel_tags.include? tag
  end

  def tag_ids=(ids)
    taggings.delete_all

    #add new tags
    ids.each { |tag_id| taggings.create(tag_id: tag_id)}
  end

  def nights
    checkin_at..(checkout_at-1.day)
  end

  def empty?
    results.empty?
  end

  def suggested_checkin_at(_user)
    checkin_at || user.suggested_checkin_at
  end

  def suggested_checkout_at(_user)
    checkout_at || suggested_checkin_at(_user) + _user.suggested_stay_length
  end

  def self.build_unfinalized(user, shop)
    new(
      user: user,
      shop: shop,
      keyword: shop.name,
      checkin_at: user.suggested_checkin_at,
      checkout_at: user.suggested_checkout_at
    ).add_suggested_room_searches
  end

  def self.create_unfinalized(user, shop)
    search = build_unfinalized(user, shop)
    search.save
    search
  end

  def add_suggested_room_searches
    self.user.suggested_num_room_searches.times { room_searches.build(adults: self.user.suggested_room_search_adults) }
    self
  end

private

  # does the shop have at least the same tags as the search?
  def tags_match?(s)
    (hotel_tags - s.hotel_tags).blank?
  end

  def future_check_in
    errors[:checkin_at] << I18n.t('search.form.errors.future_checkin') unless checkin_at >= Date.today
  end

  def later_check_out
    errors[:checkout_at] << I18n.t('search.form.errors.later_checkout') unless checkout_at > checkin_at
  end
end
