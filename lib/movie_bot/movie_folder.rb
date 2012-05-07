module MovieBot
  class MovieFolder
    attr_reader :video_files, :path, :movie_files
    
    # Initialize object and check whether the folder exist?
    def initialize(path)
      raise ArgumentError, 'Folder does not exists' unless Dir.exists?(path)
      @path = Pathname.new(path)
      
      @video_files = MovieBot::VideoFile.find_all(@path) # Raise error if emtpy
      @movie_files = @video_files - sample_files
    end
    
    # Return the IMDB number by reading from nfo
    def imdb
      @imdb ||= imdb_from_nfo
      return @imdb
    end
    
    # Return pathname object for all nfo files in the root
    def nfos
      nfos = glob('*.nfo')
      return nfos
    end

    # Return pathname object for all movie.nfo file in the root
    def movie_nfo
      glob('movie.nfo')
    end
    
    # Return pathname object for all files with basename matching 'sample' (case insensitive)
    def sample_files
      sample = video_files.entries.keep_if do |video|
        video.path.basename.to_s =~ /sample/i
      end
      return sample
    end
    
    # Retrieve movie information through IMDB object
    def imdb_info
      @imdb_info ||= Imdb::Movie.new(imdb.gsub('tt',''))
    end
        
    # Return pathname object for all first-level directories
    def directories 
      dir=@path.children.keep_if do |entry|
        entry.directory?
      end
    end
    
    private
    
    # Return full path to file matching pattern
    def glob(pattern)
      files = Pathname.glob(File.join(@path,pattern))
      files.empty? ? nil : files
    end
    
    # Read file at given path and deals with encoding
    def readnfo(path)
      begin
        path.read.encode!('UTF-8','UTF-8',:invalid => :replace)
      rescue Exception => e
        puts e.message
      end
    end
    
    # Read IMDB id from nfos
    def imdb_from_nfo
      # Ensure we read from movie.nfo first
      [movie_nfo,nfos].flatten.compact.each do |nfo|
        # Look for a unique IMDB link matching tt\d{7}
        # NOTE - NFO containing more than one IMDB link are discarded (we don't want to guess!) 
        readnfo(nfo).match(/imdb.*(tt\d{7})/) {|m| return m.captures[0] if m.captures.size == 1}
      end
      # If we get here, no match was found and we have nothing to return
      return nil
    end
  end
end
