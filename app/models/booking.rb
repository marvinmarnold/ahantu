class Booking < ActiveRecord::Base
  belongs_to :cart
  belongs_to :item
  has_many :line_items

  validates :item_id, :quantity, :name_at_checkout,
  	presence: true

  before_validation :set_vals

  def sms_summary
  	"#{checkin}-#{checkout}/item.short" 
  end

  def checkin
  	line_items.last.booking_at
  end

  def checkout
  	line_items.first.booking_at
  end

 private

 	def set_vals
 		self.name_at_checkout = item.name
 		self.quantity = 1 #in future, some items could have diff vals
 	end
end
