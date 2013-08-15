class Shop < Describable
  belongs_to :user
  belongs_to :city
  scope   :published, lambda { where(published: true) }

  mount_uploader :logo, LogoUploader

  validates :city_id,
  	presence: true
end
