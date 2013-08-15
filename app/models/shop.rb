class Shop < Describable
  belongs_to :user
  belongs_to :city
  scope   :published, lambda { where(published: true) }

  validates :city_id,
  	presence: true
end
