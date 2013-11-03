CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: "AKIAJZFJYFJ35MYWH77A",
    aws_secret_access_key: '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',
    # region: "s3-external-3"
  }
  config.fog_directory = 'ahantu'
  if Rails.env.test? or Rails.env.development?
    config.storage = :file
  else
    config.storage = :fog
  end
end

