require 'podcast_press/audio_file'
require 'podcast_press/uploader'
require 'podcast_press/config'

module PodcastPress
  def self.press!(filename, params={})
    params = load_config(params)
    audio_file = AudioFile.new(filename)
    audio_file.tag!(params)
    audio_file.rename!(params[:filename])
    audio_file.upload!(params[:s3_bucket])
    return audio_file
  end

  def self.load_config(params)
    Config.get(params)
  end

  # This method is called in the configuration file.
  def self.config(&block)
    @configuration = Config.new
    yield @configuration
  end
end
