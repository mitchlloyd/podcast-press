require 'taglib'

module PodcastPress
  # This class wraps the functionality of an ID3 tag from taglib-ruby
  class Tag
    def initialize(taglib_tag)
      @raw_tag = taglib_tag
    end

    def set_frames(params)
      set_title(params.title)
      set_track(params.episode_number)
      set_artist(params.artist)
      set_artwork(params.artwork)
      set_album(params.podcast_title)
    end

    # Setting a nil values causes a segfaults and other errors in the talib library
    # so we must be careful not to set nil values in tags in setter methods.

    def set_artwork(filename)
      return unless filename

      apic = TagLib::ID3v2::AttachedPictureFrame.new
      apic.mime_type = "image/jpeg"
      apic.description = "Cover"
      apic.type = TagLib::ID3v2::AttachedPictureFrame::FrontCover
      apic.picture = File.open(filename, 'rb') { |f| f.read }
      @raw_tag.add_frame(apic)
    end

    def set_title(title)
      @raw_tag.title = title if title
    end

    def set_track(track)
      @raw_tag.track = track.to_i if track
    end

    def set_artist(artist)
      @raw_tag.artist = artist if artist
    end

    def set_album(album)
      @raw_tag.album = album if album
    end
  end
end
