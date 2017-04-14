describe Birdbraino::Mention do
  it 'holds username and tweet text' do
    user = '@kaborso '
    tweet = '1\n2\n3\n4\n'
    mention = Birdbraino::Mention.new(user, tweet)

    expect(mention.user).to eq('@kaborso ')
    expect(mention.text).to eq('1\n2\n3\n4\n')
  end
end
