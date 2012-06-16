require 'taglib'
require 'ostruct'
require 'forwardable'
require 'podcast_press/tag'

module PodcastPress
  class AudioFile
    extend Forwardable

    def_delegators :@params, :title, :podcast_title, :date

    def initialize(filename)
      @filename = filename
    end

    # This method uses a hash of params to set ID3 tags.
    #
    # If {clear: true} is passed, then both ID3v1 and ID3vs tags are removed
    #
    def tag!(params={})
      @params = OpenStruct.new(params)

      TagLib::MPEG::File.open(@filename) do |file|
        if @params.clear
          file.strip(TagLib::MPEG::File::ID3v2 | TagLib::MPEG::File::ID3v1)
        end

        tag = Tag.new(file.id3v2_tag(true))
        tag.set_frames(@params)
        file.save
      end
    end

    def rename!(new_filename)
      return unless new_filename

      dir = File.dirname(@filename)
      File.rename(@filename, File.join(dir, new_filename))
    end

    def episode_number
      @params.episode_number.to_i.to_s
    end

    def size
      File.size(@filename)
    end

    # Return the length of play in a format that works with the
    # itunes:duration RSS tag. Example for 3 minutes, 16 seconds:
    #
    #     00:03:16
    #
    def runtime
      TagLib::MPEG::File.open(@filename) do |file|
        t = file.audio_properties.length
        mm, ss = t.divmod(60)
        hh, mm = mm.divmod(60)
        dd, hh = hh.divmod(24)

        [hh, mm, ss].map{|t| "%02d" % t}.join(':')
      end
    end
  end
end