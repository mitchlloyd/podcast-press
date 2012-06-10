require 'minitest/autorun'
require 'podcast_press/config'

describe PodcastPress::Config, "when a config file exists" do
  before do
    @file = File.open('podcast_press_config.rb', 'w') do |file|
      file << "set title: 'Hello'"
    end
  end

  after { File.delete(@file.path) }

  it "returns the settings as a hash" do
    PodcastPress::Config.get.must_equal({title: 'Hello'})
  end
end