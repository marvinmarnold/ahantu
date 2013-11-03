class Shop < Describable
  belongs_to :user
  belongs_to :city
  has_many :items
  has_many :bookings, through: :items
  has_many :carts, through: :bookings
  has_many :taggings, as: :taggable
  has_many :photos, as: :photoable
  has_many :hotel_tags, through: :taggings, class_name: "HotelTag", source: :tag
  has_many :phones
  has_many :responsibilities
  has_many :responsibles, through: :responsibilities, source: :user

  scope   :published, lambda { where(published: true) }
  scope   :not_shop, lambda { |shop| where(Shop.arel_table[:id].not_eq(shop.id)) }

  mount_uploader :logo, LogoUploader

  validates :city_id, :commission_pct, :user_id,
  	presence: true

  validates :published,
    :inclusion => { in: [true, false] }

  delegate :province,
      to: :city

  after_save :index
  after_destroy :unindex

  def to_s
    name
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

private

  def index
    SearchSuggestion.unindex_shop self
    SearchSuggestion.index_shop(self) if published?
  end

  def unindex
    SearchSuggestion.unindex_shop self
  end

end