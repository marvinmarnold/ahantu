class Item < Describable
  include Taggable

  belongs_to :shop
  has_many :photos, as: :photoable
  has_many :price_adjustments
  has_many :bookings
  has_many :carts, through: :bookings
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings, source: :tag
  accepts_nested_attributes_for :price_adjustments
  accepts_nested_attributes_for :photos

  validates :default_price, :max_adults, :quantity,
    presence: true
  validates :published,
    :inclusion => { in: [true, false] }

  scope   :published, lambda { where(published: true) }

  def price(d = Time.now)
  	default_price
  end

  def to_s
  	name
  end
end
