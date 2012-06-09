require 'minitest/autorun'
require 'fileutils'
require './podcast_press'

FILENAME = '/tmp/test_file.mp3'

describe PodcastPress::AudioFile do
  before do
    @file = File.new(FILENAME, 'w')
    @audio_file = PodcastPress::AudioFile.new(FILENAME)
  end

  after do
    @file.close
    File.delete @file.path
  end

  describe "when #prep! is called with a title" do
    before do
      @audio_file.prep!(title: 'Sweet Episode')
    end

    it "returns the title when #episode_title is called" do
      @audio_file.episode_title.must_equal 'Sweet Episode'
    end
  end
end




