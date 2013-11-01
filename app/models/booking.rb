class Booking < ActiveRecord::Base
  belongs_to :cart
  belongs_to :item
  has_many :line_items, dependent: :destroy

  validates :item_id, :quantity, :name_at_checkout,
  	presence: true

  before_validation :set_vals

  def sms_summary
  	"#{checkin}-#{checkout}/item.short"
  end

  def checkin
  	date_ordered_line_items.first.booking_at
  end

  def checkout
  	date_ordered_line_items.last.booking_at
  end

  def date_ordered_line_items
    line_items.sort { |a, b| a.booking_at <=> b.booking_at}
  end

  def shop
    item.shop
  end

  def nights
    checkin - checkout - 1
  end

  def dates
    "#{checkin} - #{checkout}"
  end

  def to_s
    item.to_s
  end

  def shop_cut
    total * shop.cut_modifier
  end

  def total
    quantity * line_items.map { |l| l.total }.reduce(:+)
  end

  def confirm
    update_attributes!(confirmed: true)
  end

 private

 	def set_vals
 		self.name_at_checkout = item.name
 		self.quantity = 1 #in future, some items could have diff vals
 	end
end
