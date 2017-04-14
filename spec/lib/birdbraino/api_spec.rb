describe Birdbraino::Api do
  it 'returns the default url' do
    user = '@kaborso '
    tweet = '1\n2\n3\n4\n'
    api = Birdbraino::Api.new

    expect(api.url).to eq('https://braino.herokuapp.com/expanding_brain.json')
  end
end
