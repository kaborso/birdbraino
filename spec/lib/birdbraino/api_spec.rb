describe Birdbraino::Api do
  before do
    @api = Birdbraino::Api.new
  end

  describe 'initialize' do
    it 'sets the default url' do
      @api = Birdbraino::Api.new

      expect(@api.url).to eq('https://braino.herokuapp.com/expanding_brain.json')
    end
  end

  describe 'meme' do
    it 'calls block' do
      tweet = '1\n2\n3\n4\n'

      response = double('response')
      allow(response).to receive_messages({
        body: '{"id":"something", "url":"somewhere"}',
        code: 200
      })
      allow(RestClient).to receive(:post).and_yield(response, {}, {})

      expect(@api).to receive(:save).once.and_call_original
      expect(Birdbraino::Image).to receive(:new).once.with('something.png', 'somewhere').and_call_original
      expect_any_instance_of(Birdbraino::Image).to receive(:download).once

      @api.meme(tweet_text:tweet) { pass }
    end

    it 'raises error' do
      response = double('response')
      allow(response).to receive_messages({
        body: '{"errors":["This test will fail."]}',
        code: 400
      })
      request = result = {}
      allow(RestClient).to receive(:post).and_yield(response, request, result)

      tweet = '1\n2\n3\n4\n'
      expect{ @api.meme }.to raise_error(StandardError)
    end
  end
end
