describe Birdbraino::Image do
  before do
    name = 'AjofdQls'
    url = 'http://someone.over.on.s3.com/AjofdQls'
    @image = Birdbraino::Image.new(name, url)
  end

  describe 'initialize' do
    it 'sets the name' do
      expect(@image.name).to eq('AjofdQls')
    end

    it 'sets the url' do
      expect(@image.url).to eq('http://someone.over.on.s3.com/AjofdQls')
    end
  end

  describe 'download' do
    before do
      @tmp_fake_local = Tempfile.new('fake_local_brains')
      @tmp_fake_local.write("empty")
      @tmp_fake_local.rewind

      @tmp_fake_remote = Tempfile.new('fake_remote_brains')
      @tmp_fake_remote.write("brains")
      @tmp_fake_remote.rewind

      allow(Tempfile).to receive(:new).and_return(@tmp_fake_local)
      allow_any_instance_of(Birdbraino::Image).to receive(:open).and_return(@tmp_fake_remote.path)
    end

    it 'saves to tempfile' do
      # Don't delete tempfile after download, but do delete it after test
      expect(@tmp_fake_local).to receive(:unlink).once
      expect(@tmp_fake_local).to receive(:unlink).once.and_call_original

      @image.download do |path|
        file = open(path)
        file_contents = file.read
        file.close
        expect(file_contents).to eq('brains')
      end
    end

    it 'closes tempfile if error' do
      allow(IO).to receive(:copy_stream).and_raise(StandardError)

      # Don't delete tempfile after download, but do delete it after test
      expect(@tmp_fake_local).to receive(:unlink).once
      expect(@tmp_fake_local).to receive(:unlink).once.and_call_original
      expect{ @image.download }.to raise_error(StandardError)
    end

    after do
      @tmp_fake_local.unlink
      @tmp_fake_remote.unlink
    end
  end
end
