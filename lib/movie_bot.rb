require "pathname"
require "fileutils"

require "movie_bot/version"
require "movie_bot/movie_folder"
require "movie_bot/video_file"
require "movie_bot/cli"
require "movie_bot/exceptions"

module MovieBot
  class Cleaner
    def initialize(folder)
      @movie = MovieFolder.new(folder)
    end
    
    def rename_folder!
      @movie.path.rename(@movie.name)
    end  
  end
end
