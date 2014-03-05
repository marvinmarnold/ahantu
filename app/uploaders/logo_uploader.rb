class LogoUploader < BaseUploader

  version :thumb do
    process :resize_to_fit => [64, 99999999]
    process quality: 30
  end

  version :logo do
    process :resize_to_fit => [300, 99999999]
    process quality: 50
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "ahantu_hotel_logo" if original_filename
  end

end
