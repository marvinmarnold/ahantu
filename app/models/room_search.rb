class RoomSearch < ActiveRecord::Base
  belongs_to :search

  validates :adults, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
