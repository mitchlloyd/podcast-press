require_relative './spec_setup'
require_relative '../lib/podcast_press'
require_relative './s3_mocks'

describe PodcastPress do
  before do
    @file = File.new(FILENAME, 'w')
  end

  after do
    File.delete(@file.path)
  end

  describe "calling #press! with s3 upload" do
    before do
      ENV['AMAZON_ACCESS_KEY_ID'] = 'abc'
      ENV['AMAZON_SECRET_ACCESS_KEY'] = '123'
      PodcastPress.press!(@file.path, s3_bucket: 'test_bucket')
    end

    it "makes a connection to s3" do
      AWS::S3::S3Object.establish_connection_call_args.must_equal([{
        access_key_id: 'abc',
        secret_access_key: '123',
      }])
    end

    it "uploads a file to S3" do
      args = AWS::S3::S3Object.store_call_args
      args[0].must_equal 'test_file.mp3'
      args[1].must_be_kind_of File
      args[2].must_equal 'test_bucket'
      args[3].must_equal({ access: :public_read })
    end
  end
end

