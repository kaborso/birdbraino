$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), 'lib'))

require 'twitter_ebooks'
require 'birdbraino'

ENV['TZ'] = 'America/New_York'

module Birdbraino
  class Bot < Ebooks::Bot
    def configure
      self.consumer_key = ENV['BIRDBRAINO_CONSUMER_KEY'] # Your app consumer key
      self.consumer_secret = ENV['BIRDBRAINO_CONSUMER_SECRET'] # Your app consumer secret
      self.delay_range = 1..6
    end

    def on_mention(tweet)
      begin
        api = Api.new(host: ENV['BIRDBRAINO_HOST'])
        mention = Mention.new(meta(tweet).reply_prefix, meta(tweet).mentionless)
        api.meme(tweet_text: mention.text) do |path|
          pictweet(mention.user, path)
        end
      rescue => e
        log e.message
        reply(tweet, meta(tweet).reply_prefix + "An error occurred while preparing your image. /cc @kaborso")
      end
    end
  end
end

Birdbraino::Bot.new("birdbraino") do |bot|
  bot.access_token = ENV['BIRDBRAINO_ACCESS_TOKEN'] # Token connecting the app to this account
  bot.access_token_secret = ENV['BIRDBRAINO_ACCESS_SECRET'] # Secret connecting the app to this account
end
