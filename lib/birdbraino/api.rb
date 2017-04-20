module Birdbraino
  class Api
    attr_reader :url
    def initialize(args={})
      host = args.fetch(:host, 'https://braino.herokuapp.com')
      @url = "#{host}/expanding_brain.json"
      @headers = {content_type: :json, accept: :json}
    end

    def meme(tweet_text:"", &block)
      @data = Birdbraino::Data.new(tweet_text).to_s
      @response = RestClient.post(@url, @data, @headers) do |response, request, result|
        case response.code
        when 200
          brains = JSON.parse(response.body)
          image_name = "#{brains['id']}.png"
          image_url = URI.unescape(brains['url'])

          save(image_name, image_url, &block)
        else
          log response.code
          log response.body

          raise "Error posting request to Braino API"
        end
      end
    end

    def save(image_name, image_url, &block)
      image = Image.new(image_name, image_url)
      image.download(&block)
    end
  end
end
