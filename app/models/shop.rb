class Shop < Describable
  belongs_to :user
  belongs_to :city
  has_many :items
  has_many :taggings, as: :taggable
  has_many :photos, as: :photoable
  has_many :hotel_tags, through: :taggings, class_name: "HotelTag", source: :tag
  has_many :phones
  has_many :responsibilities
  has_many :responsibles, through: :responsibilities, source: :user

  scope   :published, lambda { where(published: true) }

  mount_uploader :logo, LogoUploader

  validates :city_id, :commission_pct, :user_id,
  	presence: true

  validates :published,
    :inclusion => { in: [true, false] }

  def to_s
    name
  end

  def telephone
    "TODO"
  end

  def commission
    self.commission_pct/100
  end

  def cut_modifier
    1 - self.commission
  end
end