class PriceAdjustment < ActiveRecord::Base
  belongs_to :item

  validates :price, :start_at, :end_at,
    presence: true

  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
