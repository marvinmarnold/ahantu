class Item < Describable
  belongs_to :shop
  has_many :photos, as: :photoable
  scope   :published, lambda { where(published: true) }

  def price(d = Time.now)
  	default_price
  end

  def to_s
  	name
  end
end
