require 'minitest/autorun'
require 'taglib'

require './specs/spec_helpers'
require 'podcast_press'

SANDBOX = './specs/sandbox'
FILENAME = './specs/sandbox/test_file.mp3'
MP3_FIXTURE = './specs/fixtures/sine.mp3'

describe PodcastPress do
  include SpecHelpers

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
      tag_assertion(@file.path, 'TIT2', 'Sweet Episode')
    end
  end

  describe "when #press! is called with episode_number" do
    before do
      @episode = PodcastPress.press!(@file.path, episode_number: 1)
    end

    it "sets the track number tag" do
      tag_assertion(@file.path, 'TRCK', '1')
    end
  end

  describe "when #press! is called with a string episode_number" do
    before do
      @episode = PodcastPress.press!(@file.path, episode_number: "002")
    end

    it "returns the episode_number as a normalized string" do
      @episode.episode_number.must_equal '2'
    end
  end

  describe "when #press! is called with artwork" do
    before do
      @episode = PodcastPress.press!(@file.path, artwork: './specs/fixtures/artwork.jpg')
    end

    it "embeds the artwork in the file" do
      file_has_artwork_assertion(@file.path, './specs/fixtures/artwork.jpg')
    end
  end

  describe "when #press! is called with artist" do
    before do
      @episode = PodcastPress.press!(@file.path, artist: 'Britt Daniel')
    end

    it "embeds the artwork in the file" do
      tag_assertion(@file.path, 'TPE1', 'Britt Daniel')
    end
  end

  describe "when #press! is called with podcast_title" do
    before do
      @episode = PodcastPress.press!(@file.path, podcast_title: 'My Podcast')
    end

    it "returns the podcast title" do
      @episode.podcast_title.must_equal 'My Podcast'
    end

    it "sets the album tag" do
      tag_assertion(@file.path, 'TALB', 'My Podcast')
    end
  end

  describe "when #press! is called with filename" do
    before do
      @episode = PodcastPress.press!(@file.path, filename: 'new_file_name.mp3')
    end

    after { @file = File.new("#{SANDBOX}/new_file_name.mp3") }

    it "renames the file" do
      File.exist?("#{SANDBOX}/new_file_name.mp3").must_equal true
    end
  end


  ### Specs for setting dates ###

  def expect_setting_dates_to_work(episode, path, date_input)
    episode.date.must_equal date_input
    tag_assertion(path, 'TDRL', '2012-06-10')
    tag_assertion(path, 'TDRC', '2012')
  end

  describe "when #press! is called with a date string" do
    before do
      @date_string = '2012/06/10'
      @episode = PodcastPress.press!(@file.path, date: @date_string)
    end

    it "sets dates correctly" do
      expect_setting_dates_to_work(@episode, @file.path, @date_string)
    end
  end

  describe "when #press! is called with a time object" do
    before do
      @time_object = Time.new(2012, 6, 10)
      @episode = PodcastPress.press!(@file.path, date: @time_object)
    end

    it "sets dates correctly" do
      expect_setting_dates_to_work(@episode, @file.path, @time_object)
    end
  end


  ### Specs for getters on episodes ###

  describe "#size" do
    it "returns the size of the file" do
      PodcastPress.press!(@file.path).size.must_equal(File.size(@file.path))
    end
  end

  describe "#runtime" do
    it "returns the runtime of the file in an iTunes friendly format" do
      PodcastPress.press!(MP3_FIXTURE).runtime.must_equal('00:00:01')
    end
  end


  describe "a file with existing ID3 tags" do
    before do
      PodcastPress.press!(@file.path, title: 'remove-title', artist: 'remove-artist')
    end

    describe "when #press! is called with {clear: true}" do
      before do
        @episode = PodcastPress.press!(@file.path, clear: true)
      end

      it "removes all of the tags from the file" do
        tag_assertion(@file.path, 'TPE1', '')
        tag_assertion(@file.path, 'TIT2', '')
      end
    end
  end
end
