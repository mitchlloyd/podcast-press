require 'taglib'

module PodcastPress
  class AudioFile
    def initialize(filename)
      @filename = filename
    end

    def prep!(params={})
      @params = params

      TagLib::MPEG::File.open(@filename) do |file|
        tag = file.id3v2_tag
        tag.title = episode_title
        file.save
      end
    end

    def episode_title
      @params[:title]
    end
  end
end