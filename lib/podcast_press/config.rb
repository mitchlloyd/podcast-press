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
        # puts "WARNING: Couldn't find #{CONFIG_FILE} in #{Dir.pwd}."
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

    # Get a previously set value from config.
    def get(setting, options={})
      # Passing :min_digits as an option will pad a number with zeros.
      if options[:min_digits] and @store[setting].to_s.match(/^\d+$/)
        "%0#{options[:min_digits]}d" % @store[setting]
      else
        @store[setting]
      end
    end

    def to_h
      @store
    end
  end
end