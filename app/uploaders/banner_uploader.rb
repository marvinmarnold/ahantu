class BannerUploader < BaseUploader

  version :thumb do
    process :resize_to_fit => [200, 200]
  end

  version :banner do
    process :resize_to_fit => [3200, 800]
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "shop" if original_filename
  end

end
