module PodcastPress
  class AudioFile
    def initialize(filename)
      @filename = filename
    end

    def prep!(params={})
      @params = params
    end

    def episode_title
      @params[:title]
    end
  end
end