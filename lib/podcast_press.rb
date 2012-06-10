require 'podcast_press/audio_file'
require 'podcast_press/config'

module PodcastPress
  def self.press!(filename, params={})
    params = load_config.merge(params)
    audio_file = AudioFile.new(filename)
    audio_file.tag!(params)
    audio_file.rename!(params[:filename])
    return audio_file
  end

  def self.load_config
    Config.get
  end

  # This method is called in the configuration file.
  def self.config(&block)
    @configuration = Config.new
    yield @configuration
  end
end