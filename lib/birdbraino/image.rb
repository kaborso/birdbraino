module Birdbraino
  class Image
    attr_accessor :url, :path, :name

    def initialize(name, url)
      @url = url
      @name = name
    end

    def operate(&block)
      path = download
      yield path
    end

    def download
      begin
        file = Tempfile.new(name)
        @path = file.path
        downloaded_file = open(url)
        puts url
        IO.copy_stream(downloaded_file, @path)
        puts @path
        return @path
      rescue
      ensure
      # fix (non)blocking issue
      #  file.close
      #  file.unlink
      end
      return path
    end
  end
end
