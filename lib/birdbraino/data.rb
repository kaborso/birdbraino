module Birdbraino
  class Data
    def initialize(tweet_text)
      lines = tweet_text.split('\n')
      @brains = {brains: lines}
    end

    def to_s
      @brains.to_json
    end
  end
end
