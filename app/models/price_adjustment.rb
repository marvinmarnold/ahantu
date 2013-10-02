class PriceAdjustment < ActiveRecord::Base
  belongs_to :item

  validates :price, :start_at, :end_at,
    presence: true
end
