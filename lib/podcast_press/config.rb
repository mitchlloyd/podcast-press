CONFIG_FILE = './podcast_press_config.rb'

module PodcastPress
  class Config
    def initialize
      @store = {}
    end

    # TODO: Some meta prgramming to make this work for everything.
    def title(value)
      @store[:title] = value
    end

    def to_h
      @store
    end

    def self.load
      require CONFIG_FILE if File.exist?(CONFIG_FILE)
    end
  end
end