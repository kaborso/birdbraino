require 'bots'

describe Birdbraino::Bot do
  before do
    metatweet = double('metatweet')
    allow(metatweet).to receive_messages({
      mentionless: '\n 1 \n 2 \n 3 \n 4',
      reply_prefix: '@birdbraino '
    })
    allow_any_instance_of(Birdbraino::Bot).to receive(:meta).and_return(metatweet)

    response = double('response')
    allow(response).to receive_messages({
      body: '{"id":"", "url":""}',
      code: 200
    })
    request = result = {}
    allow(RestClient).to receive(:post).and_yield(response, request, result)
    allow(IO).to receive(:copy_stream).and_return(true)

    tempfile = double('tempfile')
    allow(tempfile).to receive_messages({
      close: true,
      unlink: true,
      path: '/tmp/somefile'
    })
    allow(Tempfile).to receive(:new).and_return(tempfile)
    allow(Birdbraino::Image).to receive(:new).and_call_original
    allow_any_instance_of(Birdbraino::Image).to receive(:download).and_return('/tmp/somefile')
    allow_any_instance_of(Birdbraino::Bot).to receive(:pictweet)
  end

  it 'goes from text to image' do
    expect_any_instance_of(Birdbraino::Bot).to receive(:pictweet)

    tweet = double('tweet')
    test_bot = Birdbraino::Bot.new('birdbraino_test')
    test_bot.on_mention(tweet)
  end
end
