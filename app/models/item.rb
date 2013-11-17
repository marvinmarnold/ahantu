require 'item_availability'

class Item < Describable
  include Taggable

  belongs_to :shop
  has_many :photos, as: :photoable, dependent: :destroy
  has_many :price_adjustments, dependent: :destroy
  has_many :bookings
  has_many :line_items, through: :bookings
  has_many :carts, through: :bookings
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings, source: :tag

  accepts_nested_attributes_for :price_adjustments, allow_destroy: true
  accepts_nested_attributes_for :photos, allow_destroy: true

  validates :default_price, :max_adults, :quantity,
    presence: true
  validates :published,
    :inclusion => { in: [true, false] }

  scope   :published, lambda { where(published: true) }
  scope   :big_enough, ->(num_adults) { where("max_adults >= ?", num_adults) }

  def price(d = Time.now)
  	default_price
  end

  def to_s
  	name
  end

  def num_available(date)
    quantity - num_unavailable(date)
  end

  def num_unavailable(date)
    line_items.where(:booking_at => date).size
  end
end
