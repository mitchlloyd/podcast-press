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

  describe "when getting episode_number with a min_digits option" do
    before do
      File.open(CONFIG_FILE, 'w') do |f|
        f << %Q{set episode_number: 3 \n}
        f << %q{set title: "#{get :episode_number, min_digits: 3}"}
      end
    end

    it "returns a number with zeros for padding to reach the minimum number of digits" do
      PodcastPress::Config.get[:title].must_equal '003'
    end
  end
end