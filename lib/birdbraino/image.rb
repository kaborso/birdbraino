module Birdbraino
  class Image
    attr_accessor :url, :name

    def initialize(name, url)
      @url = url
      @name = name
    end

    def download(&block)
      begin
        file = Tempfile.new(name)

        local_file = file.path
        remote_file = open(url)

        IO.copy_stream(remote_file, local_file)

        yield local_file
      rescue => e
        log "#{e.class} #{e.message}"

        raise "Error manipulating image file"
      ensure
       file.close
       file.unlink
      end
    end
  end
end
