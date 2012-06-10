require 'minitest/autorun'
require 'podcast_press'

describe "Config when a config file exists" do
  before do
    @file = File.open('podcast_press_config.rb', 'w') do |file|
      file << "require 'podcast_press' \n"
      file << "PodcastPress.config {|c| c.title 'Hello'}"
    end
  end

  after { File.delete(@file.path) }

  it "returns the settings as a hash" do
    PodcastPress.load_config.must_equal({title: 'Hello'})
  end
end