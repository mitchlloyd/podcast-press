require 'minitest/autorun'
require 'podcast_press/config'

CONFIG_FILE = 'podcast_press_config.rb'

describe PodcastPress::Config do
  describe "when a property is set" do
    before do
      File.open(CONFIG_FILE, 'w') {|f| f << "set title: 'Hello'"}
    end

    after { File.delete CONFIG_FILE }

    it "returns the settings as a hash" do
      PodcastPress::Config.get.must_equal({title: 'Hello'})
    end
  end

  describe "when previousely set values are called" do
    before do
      File.open(CONFIG_FILE, 'w') do |f|
        f << %Q{set title: "Hello" \n}
        f << %q{set artist: "#{get(:title)}"}
      end
    end

    after { File.delete CONFIG_FILE }

    it "returns the settings as a hash" do
      hash = PodcastPress::Config.get
      hash[:artist].must_equal "Hello"
    end
  end
end