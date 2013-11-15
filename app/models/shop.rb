class Shop < Describable
  include Taggable

  belongs_to :user, inverse_of: :owned_shops
  belongs_to :location
  has_many :items
  has_many :bookings, through: :items
  has_many :carts, through: :bookings
  has_many :taggings, as: :taggable
  has_many :photos, as: :photoable
  has_many :phones
  has_many :responsibilities
  has_many :responsibles, through: :responsibilities, source: :user
  has_many :tags, through: :taggings, source: :tag
  has_many :hotel_tags, through: :taggings, source: :tag, class_name: "Tag::HotelTag"

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

private

  def unindex
    SearchSuggestion.unindex_shop self
  end

  def published_and_valid
    errors[:published] << I18n.t('shop.form.errors.published_and_valid') if published? && user_id.blank?
  end

end