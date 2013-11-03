class Search < ActiveRecord::Base
  belongs_to :user
  belongs_to :shop
  has_many :taggings, as: :taggable
  has_many :hotel_tags, through: :taggings, class_name: "Tag::HotelTag", source: :tag
  has_many :room_searches

  accepts_nested_attributes_for :room_searches

  validate :future_check_in, :later_check_out
  validates :keyword, :checkin_at, :checkout_at, :user_id,
    presence: true

  def results(filtered_shops = Shop.published)
    filtered_shops = filtered_by_keyword(filtered_shops)
    filtered_shops = filtered_by_hotel_tags(filtered_shops)
    filtered_shops.uniq
  end

  def filtered_by_keyword(filtered_shops = Shop.published)
    k = "%#{self.keyword}%"
    if self.keyword.present?
      filtered_shops = filtered_shops.joins(:city => :province).joins(:descriptions).
        where("descriptions.name ilike :k or description ilike :k or cities.name ilike :k or provinces.name ilike :k",
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

  def has_hotel_tag?(tag)
    hotel_tags.include? tag
  end

  def tag_ids=(ids)
    taggings.delete_all

    #add new tags
    ids.each { |tag_id| taggings.create(tag_id: tag_id)}
  end

  def dates
    checkin_at..(checkout_at-1.day)
  end

  def active?
    self.created_at > [self.user.last_checkout_at, 1.week.ago].max
  end

  def empty?
    results.empty?
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
