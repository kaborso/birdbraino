module Birdbraino
  class Mention  < Ebooks::Bot
    attr_accessor :user, :text
    def initialize(tweeter, tweet)

      @user = tweeter
      @text = tweet
    end
  end
end
