require 'aws/s3'

class Uploader
  attr_accessor :bucket_name

  def initialize(bucket_name)
    self.bucket_name = bucket_name

    AWS::S3::Base.establish_connection!(
      access_key_id: ENV['AMAZON_ACCESS_KEY_ID'],
      secret_access_key: ENV['AMAZON_SECRET_ACCESS_KEY']
    )
  end

  def upload(file_path)
    file_name = File.basename(file_path)
    AWS::S3::S3Object.store(
      file_name,
      open(file_path),
      bucket_name,
      access: :public_read
    )
    url(file_name)
  end

  def url(file_name)
    "https://s3.amazonaws.com/#{bucket_name}/#{file_name}"
  end
end
