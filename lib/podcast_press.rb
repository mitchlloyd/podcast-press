require 'podcast_press/audio_file'

module PodcastPress
  def self.press!(filename, params={})
    audio_file = AudioFile.new(filename)
    audio_file.tag!(params)
    return audio_file
  end
end