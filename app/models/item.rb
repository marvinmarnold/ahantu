class Item < Describable
  belongs_to :shop
  has_many :photos, as: :photoable

  validates :default_price, :max_adults, :short, :quantity,
    presence: true
  validates :published,
    :inclusion => { in: [true, false] }

  scope   :published, lambda { where(published: true) }

  def price(d = Time.now)
  	default_price
  end

  def to_s
  	name
  end
end
