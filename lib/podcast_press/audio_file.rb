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

    # This method uses a hash of params to set ID3 tags.
    #
    # If {clear: true} is passed, then both ID3v1 tags are removed
    # (these reside on the last 128 bytes) as well as the ID3v2 frames.
    #
    def tag!(params={})
      @params = OpenStruct.new(params)

      remove_id3v1_data! if @params.clear

      TagLib::MPEG::File.open(@filename) do |file|
        tag = Tag.new(file.id3v2_tag)

        tag.clear_frames if @params.clear

        tag.set_title(@params.title)
        tag.set_track(@params.episode_number)
        tag.set_artist(@params.artist)
        tag.set_artwork(@params.artwork)

        file.save
      end
    end

    def rename!(new_filename)
      return unless new_filename

      dir = File.dirname(@filename)
      File.rename(@filename, File.join(dir, new_filename))
    end

    def episode_number(options={})
      if (padding_amount = options[:padding])
        "%0#{padding_amount}d" % @params.episode_number
      else
        @params.episode_number
      end
    end


    private

    def remove_id3v1_data!
      if has_id3v1_tag?
        # Remove the last 128 bytes of the file.
        new_file_length = File.size(@filename) - 128
        File.truncate(@filename, new_file_length)
      end
    end

    def has_id3v1_tag?
      # Read the last 128 bytes of the file which may contain
      # the id3 tag data.
      file = File.new(@filename)
      file.seek(-128,IO::SEEK_END)
      file.read(3).unpack('A3').first == 'TAG'
    end
  end
end