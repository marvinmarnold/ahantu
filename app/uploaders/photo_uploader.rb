class PhotoUploader < BaseUploader

  version :thumb do
    process :resize_to_fit => [40, 60]
  end

  version :main do
    process :resize_to_fit => [400, 600]
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "shop" if original_filename
  end

end
