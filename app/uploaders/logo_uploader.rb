class LogoUploader < BaseUploader

  version :thumb do
    process :resize_to_fit => [64, 64]
  end

  version :preview do
    process :resize_to_fit => [400, 400]
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "shop" if original_filename
  end

end
