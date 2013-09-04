class Booking < ActiveRecord::Base
  belongs_to :cart
  belongs_to :item
  has_many :line_items
end
