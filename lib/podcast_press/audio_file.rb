require 'taglib'
require 'ostruct'
require 'forwardable'
require 'podcast_press/tag'

module PodcastPress
  class AudioFile
    extend Forwardable

    def_delegators :@params, :title

    def initialize(filename)
      @filename = filename
    end

    def tag!(params={})
      @params = OpenStruct.new(params)

      TagLib::MPEG::File.open(@filename) do |file|
        tag = Tag.new(file.id3v2_tag)

        tag.set_title(@params.title)
        tag.set_track(@params.episode_number)
        tag.set_artwork(@params.artwork)

        file.save
      end
    end

    def episode_number(options={})
      if (padding_amount = options[:padding])
        "%0#{padding_amount}d" % @params.episode_number
      else
        @params.episode_number
      end
    end
  end
end