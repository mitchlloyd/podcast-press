CONFIG_FILE = './podcast_press_config.rb'

module PodcastPress
  class Config
    def initialize
      @store = {}
    end

    def self.get
      @instance = self.new()

      if File.exist?(CONFIG_FILE)
        # In this config file, users will call #set to set their defaults.
        @instance.instance_eval File.read(CONFIG_FILE), CONFIG_FILE, 1
      else
        raise "Couldn't find #{CONFIG_FILE} in #{Dir.pwd}."
      end

      @instance.to_h
    end

    # In the config file, users will do things like:
    #
    #   set title: 'My Title'
    #
    def set(setting)
      @store.merge!(setting)
    end

    def to_h
      @store
    end
  end
end