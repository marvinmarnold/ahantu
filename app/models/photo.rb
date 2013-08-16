class Photo < ActiveRecord::Base
  belongs_to :photoable, polymorphic: true
  attr_accessible :image, :image_cache, :photoable

  mount_uploader :image, PhotoUploader
end
