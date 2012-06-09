require 'minitest/autorun'
require 'tempfile'
require 'taglib'

require 'podcast_press'

FILENAME = './sandbox/test_file.mp3'

describe PodcastPress do
  describe "when #press! is called with a title" do
    before do
      @file = File.new(FILENAME, 'w')
      @episode = PodcastPress.press!(@file.path, title: 'Sweet Episode')
    end

    after do
      File.delete(@file.path)
    end

    it "returns the title when #title is called" do
      @episode.title.must_equal 'Sweet Episode'
    end

    it "sets the title ID3 tag to the given title" do
      TagLib::FileRef.open(@file.path) do |file|
        file.tag.title.must_equal 'Sweet Episode'
      end
    end
  end
end
