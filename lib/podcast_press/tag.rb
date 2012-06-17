require 'taglib'
require 'time'

module PodcastPress
  # This class wraps the functionality of an ID3 tag from taglib-ruby
  class Tag
    def initialize(taglib_tag)
      @raw_tag = taglib_tag
      raise "taglib tag passed was nil. Quitting." unless @raw_tag
    end

    def set_frames(params)
      set_title(params.title)
      set_track(params.episode_number)
      set_artist(params.artist)
      set_artwork(params.artwork)
      set_album(params.podcast_title)
      set_release_date(params.date)
      set_genre(params.genre)
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

    def set_release_date(date_input)
      return false unless date_input

      if date_input.is_a? String
        date = Time.parse(date_input).strftime('%Y-%m-%d')
      elsif date_input.is_a? Time
        date = date_input.strftime('%Y-%m-%d')
      else
        raise "Don't konw how to handle given time: #{date}"
      end

      @raw_tag.remove_frames('TDRL')
      frame = TagLib::ID3v2::TextIdentificationFrame.new('TDRL', TagLib::String::UTF8)
      frame.text = date
      @raw_tag.add_frame(frame)
      @raw_tag.year = date.split('-').first.to_i
    end

    def set_genre(genre)
      @raw_tag.genre = genre || 'Podcast'
    end
  end
end
