describe Birdbraino::Data do
  it 'converts four linebreaks to four brains' do
    tweet = '1\n2\n3\n4\n'
    final = { brains: ['1', '2', '3', '4'] }.to_json

    expect(Birdbraino::Data.new(tweet).to_s).to eq(final)
  end
end
