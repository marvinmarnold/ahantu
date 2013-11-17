class Shop < Describable
  include Taggable

  belongs_to :user, inverse_of: :owned_shops
  belongs_to :location
  has_many :items
  has_many :bookings, through: :items
  has_many :carts, through: :bookings
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :photos, as: :photoable, dependent: :destroy
  has_many :phones
  has_many :responsibilities, dependent: :destroy
  has_many :responsibles, through: :responsibilities, source: :user
  has_many :tags, through: :taggings, source: :tag
  has_many :hotel_tags, through: :taggings, source: :tag, class_name: "Tag::HotelTag"

  accepts_nested_attributes_for :photos, allow_destroy: true

  attr_accessor :shop_request_id

  scope   :published, lambda { where(published: true) }
  scope   :not_shop, lambda { |shop| where.not(id: shop.id) }
  scope   :unowned, lambda { where(user_id: nil) }

  mount_uploader :logo, LogoUploader

  validates :location_id, :commission_pct, :directions,
  	presence: true

  validates :published,
    :inclusion => { in: [true, false] }

  validate :published_and_valid

  after_destroy :unindex
  after_create :fill_shop_request

  def to_s
    name
  end

  def last_sale
    carts.order("submitted_at DESC").first.try(:submitted_at)
  end

  def telephone
    "TODO"
  end

  def commission
    self.commission_pct/100
  end

  def cut_modifier
    1 - self.commission
  end

  def display_price
    items.map { |i| i.price }.min
  end

  def published?
    published
  end

  def locations
    location.ancestors.reverse
  end

  def owner
    self.user
  end

  def fill_shop_request
    if shop_request_id.present?
      shop_request = ShopRequest.find(shop_request_id)
      shop_request.update_attributes(shop_id: self.id)
      shop_request.complete
      update_attributes(user_id: shop_request.shop_owner.id)
    end
  end

  # returns hash of { item_id => num available on date }
  # only rooms where max_adults > adults will be included in hash
  # num of rooms available must be > 0
  def available_items(date, adults)
    [].tap { |a| items.big_enough(adults).map do |item|
      num_rooms_available = item.num_available(date)
      a << ItemAvailability.new(item: item, quantity: num_rooms_available, max_adults: item.max_adults ) if num_rooms_available > 0
    end}.sort { |x, y| x.max_adults <=> y.max_adults }
  end

  def num_available_items(date, adults)
    available_items(date, adults).inject(0) { |sum, item_availability| sum + item_availability.quantity }
  end

private

  def unindex
    SearchSuggestion.unindex_shop self
  end

  def published_and_valid
    errors[:published] << I18n.t('shop.form.errors.published_and_valid') if published? && user_id.blank?
  end

end