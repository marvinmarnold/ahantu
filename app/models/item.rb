require 'item_availability'

class Item < Describable
  include Taggable

  belongs_to :shop
  has_many :photos, as: :photoable, dependent: :destroy
  has_many :price_adjustments, dependent: :destroy
  has_many :bookings, inverse_of: :item
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

  validates :default_price, numericality: { greater_than_or_equal_to: 0 }

  scope   :published, lambda { where(published: true) }
  scope   :big_enough, ->(num_adults) { where("max_adults >= ?", num_adults) }

  # t1, t2 inclusive
  def price_over_period(t1, t2)
    daily_prices = (t1..t2).map { |t| price t }
    daily_prices.inject{ |sum, el| sum + el }.to_f / daily_prices.size
  end

  def price(d = Time.zone.now)
    if p = price_adjustments.find { |p| p.start_at.to_date <= d && p.end_at.to_date >= d}
      p.price
    else
  	 default_price
    end
  end

  def search_price(search)
    search.persisted? ?  price_over_period(search.checkin_at, search.checkout_at - 1.day) : default_price
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
