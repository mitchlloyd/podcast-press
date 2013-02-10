require 'taglib'

module SpecHelpers
  def tag_assertion(filename, tag_id, value)
    TagLib::MPEG::File.open(filename) do |file|
      tag = file.id3v2_tag.frame_list(tag_id).first
      tag.to_s.must_equal(value)
    end
  end

  def file_has_artwork_assertion(audio_filename, pic_filename)
    TagLib::MPEG::File.open(audio_filename) do |file|
      expected_data = File.open(pic_filename) {|f| f.read}
      tag = file.id3v2_tag.frame_list('APIC').first
      tag.picture.length.must_equal(expected_data.length)
    end
  end
end
