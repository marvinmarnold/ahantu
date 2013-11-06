class Shop < Describable
  include Taggable

  belongs_to :user
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
  scope   :published, lambda { where(published: true) }
  scope   :not_shop, lambda { |shop| where.not(id: shop.id) }

  mount_uploader :logo, LogoUploader

  validates :location_id, :commission_pct, :user_id,
  	presence: true

  validates :published,
    :inclusion => { in: [true, false] }

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

  def locations
    location.ancestors.reverse
  end

  def owner
    self.user
  end

private

  def unindex
    SearchSuggestion.unindex_shop self
  end

end