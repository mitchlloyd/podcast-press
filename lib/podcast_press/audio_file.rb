require 'taglib'

module PodcastPress
  class AudioFile
    def initialize(filename)
      @filename = filename
    end

    def tag!(params={})
      @params = params

      TagLib::MPEG::File.open(@filename) do |file|
        tag = file.id3v2_tag
        tag.title = title
        file.save
      end
    end

    def title
      @params[:title]
    end
  end
end