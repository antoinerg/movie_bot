require "imdb"

module MovieBot
  class MovieFolder
    # Initialize object and check whether the folder exist?
    def initialize(path)
      raise ArgumentError, 'Folder does not exists' unless Dir.exists?(path)
      @path = Pathname.new(path)
    end

    # Return the IMDB number by reading from nfo, and then by looking in the db
    def imdb
      @imdb ||= imdb_from_nfo
      raise StandardError, "IMDB id not found" if @imdb.nil? 
      return @imdb
    end
    
    # Return path to all nfo files in the root
    def nfos
      nfos = glob('*.nfo')
      raise StandardError, "No NFO found" if nfos.nil?
      return nfos
    end

    # Return path to movie.nfo file in the root
    def movie_nfo
      glob('movie.nfo')
    end
    
    # Retrieve movie information through IMDB object
    def imdb_info
      @imdb_info ||= Imdb::Movie.new(self.imdb.gsub('tt',''))
    end
    
    private
    
    # Return full path to file matching pattern
    def glob(pattern)
      files = Dir.glob(File.join(@path,pattern))
      files.empty? ? nil : files
    end
    
    # Read file at given path and deals with encoding
    def readnfo(path)
      begin
        File.read(path).encode!('UTF-8','UTF-8',:invalid => :replace)
      rescue Exception => e
        puts e.message
      end
    end
    
    # Try to read IMDB id from nfos
    # It first looks into movie.nfo and then the rest
    # id is discarded if there's more than one match in a folder
    def imdb_from_nfo
      [movie_nfo,nfos].flatten.compact.each do |nfo|
        m=readnfo(nfo).match(/imdb.*(tt\d{7})/).captures
        return m[0] if m.size == 1 
      end
      # If we get here, no match was found and we have nothing to return
      return nil
    end
  end
end
