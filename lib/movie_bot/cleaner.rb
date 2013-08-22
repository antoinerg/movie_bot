#require 'xbmc_library'

module MovieBot
  class Cleaner
    attr_reader :movie
    attr_accessor :imdb

    Configuration.path = "#{ENV['HOME']}/.movie_bot"
    CONFIG = Configuration.load 'movie_bot'

    def initialize(folder)
      @movie = MovieFolder.new(folder)
    end

    def clean!
      create_movie_nfo! && rename_folder! && move_folder!
    end
   
    def imdb=(i)
      raise ArgumentError unless i.is_a?(String)
      @imdb = i
    end

    # Return normalized name
    def name
      title = movie.imdb_info.title
      year = movie.imdb_info.year
      "#{title} (#{year})"
    end
    
    def move_folder!
      if dst = ENV['DEST_DIR']
        FileUtils.mv(@movie.path,dst)
      else
        puts "Set DEST_DIR to move file"
      end
    end
    
    def rename_folder!
      if imdb
        puts "Renaming folder '#{@movie.path.basename.to_s}' to '#{name}'"
        newpath = @movie.path.dirname + name
        @movie.path.rename(newpath)
        @movie = MovieFolder.new(newpath)
        return true
      else
        puts "Can't rename based on an IMDB lookup"
        return false
      end
    end
    
    def imdb
      begin
        @imdb ||= @movie.imdb
        return @imdb
      rescue ImdbIDNotFound
        puts "Can't find IMDB ID"
        return nil
        # Should interactively query IMDB here
      end
    end
  
    def create_movie_nfo!
      if @movie.movie_nfo.nil?
        "No movie NFO in folder:"
        url = "http://www.imdb.com/title/#{self.imdb}/"
        puts "Writing movie.nfo"
        File.open(File.join(@movie.path.to_s,'movie.nfo'), 'w') do |f|
          f.write(url)
        end
      else
        
      end
      return true
    end
  end
end
