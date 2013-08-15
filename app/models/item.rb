class Item < Describable
  belongs_to :shop
  scope   :published, lambda { where(published: true) }
end
