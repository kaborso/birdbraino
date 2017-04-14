$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), 'lib'))

require 'twitter_ebooks'
require 'birdbraino'

ENV['TZ'] = 'America/New_York'

module Birdbraino
  class Bot < Ebooks::Bot
    def configure
      self.consumer_key = ENV['BIRDBRAIND_CONSUMER_KEY'] # Your app consumer key
      self.consumer_secret = ENV['BIRDBRAIND_CONSUMER_SECRET'] # Your app consumer secret
      self.delay_range = 1..6
    end

    def on_mention(tweet)
      api = Api.new(host:ENV['BIRDBRAINO_HOST'])
      mention = Mention.new(meta(tweet).reply_prefix, meta(tweet).mentionless)
      api.meme(tweet_text: mention.text) do |path|
        pictweet(mention.user, path)
      end
    end
  end
end

Birdbraino::Bot.new("birdbraino") do |bot|
  bot.access_token = ENV['BIRDBRAIND_ACCESS_TOKEN'] # Token connecting the app to this account
  bot.access_token_secret = ENV['BIRDBRAIND_ACCESS_SECRET'] # Secret connecting the app to this account
end
