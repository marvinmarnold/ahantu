class PhotoUploader < BaseUploader

  version :thumb do
    process :resize_to_fit => [60, 999999999]
    process quality: 30
  end

  version :main do
    process :resize_to_fit => [800, 99999999]
    process quality: 30
  end

  # # Override the filename of the uploaded files:
  # # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "ahantu" if original_filename
  # end

end
