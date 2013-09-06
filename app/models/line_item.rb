class LineItem < ActiveRecord::Base
  belongs_to :booking

  def total
  	unit_price_at_checkout
  end
end
