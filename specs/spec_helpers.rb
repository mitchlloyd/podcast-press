require 'taglib'

module SpecHelpers
  def tag_assertion(filename, tag_id, value)
    TagLib::MPEG::File.open(filename) do |file|
      tag = file.id3v2_tag.frame_list(tag_id).first
      tag.to_s.must_equal(value)
    end
  end
end