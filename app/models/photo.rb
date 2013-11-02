class Photo < ActiveRecord::Base
  belongs_to :photoable, polymorphic: true

  mount_uploader :photo, PhotoUploader
end
