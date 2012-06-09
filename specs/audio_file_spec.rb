require 'minitest/autorun'
require 'tempfile'
require 'taglib'

require 'podcast_press'

FILENAME = './sandbox/test_file.mp3'

describe PodcastPress do
  before do
    @file = File.new(FILENAME, 'w')
  end

  after do
    File.delete(@file.path)
  end

  describe "when #press! is called with a title" do
    before do
      @episode = PodcastPress.press!(@file.path, title: 'Sweet Episode')
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

  describe "when #press! is called with episode_number" do
    before do
      @episode = PodcastPress.press!(@file.path, episode_number: 1)
    end

    it "returns the episode_number with padding" do
      @episode.episode_number(padding: 3).must_equal '001'
    end

    it "sets the track number tag" do
      TagLib::FileRef.open(@file.path) do |file|
          file.tag.track.must_equal 1
      end
    end
  end
end
