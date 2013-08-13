class City < ActiveRecord::Base
  belongs_to :province

  validates :province_id, :name,
  	presence: true
end
