require 'taglib'
require 'ostruct'
require 'forwardable'

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
        tag = file.id3v2_tag

        # Setting a nil values causes a segfaults and other errors in the talib library
        tag.title = title if title
        tag.track = episode_number if episode_number

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