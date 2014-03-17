class BannerUploader < BaseUploader

  version :banner do
    process :resize_to_fit => [3200, 99999999999]
    process quality: 60
  end

  # # Override the filename of the uploaded files:
  # # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "ahantu_hotel_banner" if original_filename
  # end

end
