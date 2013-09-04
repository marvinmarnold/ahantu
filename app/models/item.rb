class Item < Describable
  belongs_to :shop
  has_many :photos, as: :photoable
  scope   :published, lambda { where(published: true) }

  def price
  	default_price
  end
end
