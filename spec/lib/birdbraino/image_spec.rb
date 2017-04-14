describe Birdbraino::Data do
  it 'sets the name' do
    name = 'AjofdQls'
    url = 'http://someone.over.on.s3.com/AjofdQls'

    expect(Birdbraino::Image.new(name, url).name).to eq(name)
  end
  it 'sets the url' do
    name = 'AjofdQls'
    url = 'http://someone.over.on.s3.com/AjofdQls'

    expect(Birdbraino::Image.new(name, url).url).to eq(url)
  end
end
