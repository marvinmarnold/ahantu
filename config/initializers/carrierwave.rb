CarrierWave.configure do |config|
  #Be careful about bucket names
  #http://stackoverflow.com/questions/18340551/amazon-s3-hostname-does-not-match-the-server-certificate-opensslsslsslerr
  config.fog_directory = ENV["AWS_S3_BUCKET"]
  if Rails.env.test? or Rails.env.development?
    config.storage = :file
  else
    config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
    aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
    # region: "s3-external-3"
    }
    config.storage = :fog
  end
end

module CarrierWave
  module RMagick

    def quality(percentage)
      manipulate! do |img|
        img.write(current_path){ self.quality = percentage } unless img.quality == percentage
        img = yield(img) if block_given?
        img
      end
    end

  end
end
