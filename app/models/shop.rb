class Shop < Describable
  belongs_to :user
  belongs_to :city
  has_many :items
  has_many :taggings, as: :taggable
  has_many :photos, as: :photoable
  has_many :hotel_tags, through: :taggings, class_name: "HotelTag", source: :tag
  has_many :phones

  validates :published, 
    :inclusion => { in: [true, false] }
    
  scope   :published, lambda { where(published: true) }

  mount_uploader :logo, LogoUploader

  validates :city_id,
  	presence: true

end
