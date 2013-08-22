#require 'xbmc_library'

module MovieBot
  class Cleaner
    TITLE_CLEANERS = YAML.load(File.read(File.join(File.dirname(__FILE__),"strings.yaml")))["cleaners"]
    
    attr_reader :movie
    attr_accessor :imdb

    #Configuration.path = "#{ENV['HOME']}/.movie_bot"
    #CONFIG = Configuration.load 'movie_bot'

    def initialize(folder)
      @movie = MovieFolder.new(folder)
    end

    def clean!
      create_movie_nfo! && rename_folder! && move_folder!
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
        return @movie.imdb
      rescue ImdbIDNotFound
        puts "Can't find IMDB ID"
        title = @movie.path.basename.to_s
        
        return self.search_imdb(self.class.title_clean(title))
        # Should interactively query IMDB here
      end
    end
  
    def create_movie_nfo!
      if @movie.movie_nfo.nil?
        "No movie NFO in folder:"
        if imdb
          url = "http://www.imdb.com/title/#{imdb}/"
          puts "Writing movie.nfo"
          File.open(File.join(@movie.path.to_s,'movie.nfo'), 'w') do |f|
            f.write(url)
          end
        else
          return false
        end
      end
      return true
    end
  
    def search_imdb(title)
      puts "Searching IMDB for: #{title}"
      
      i = Imdb::Search.new(title)
      i.movies[0..9].each_with_index do |m,i|
        puts "#{i+1} : #{m.title}"
      end
    
      puts "Select movie"
      input = $stdin.gets
      id = input.to_i
      
      if id == 0
        return search_imdb(input)
      else
        @movie.imdb = "tt#{i.movies[id-1].id}"
        return @movie.imdb
      end
    end
    
    def self.title_clean(title)
      TITLE_CLEANERS.each do |t|
        title.gsub!(/#{t}/i,'')
      end
      
      title.gsub!(/\s{2,}/,'')
      
      m=title.match(/(.*) \(?(\d{4})\)?.*/)
      return "#{m[1]} (#{m[2]})"
    end
  end
end