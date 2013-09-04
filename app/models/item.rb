class Item < Describable
  belongs_to :shop
  has_many :photos, as: :photoable
  scope   :published, lambda { where(published: true) }
end
