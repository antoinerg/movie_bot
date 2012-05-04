require 'movie_bot'
require 'thor'

module MovieBot
  class CLI < Thor
    desc "scan", "Scan current folder"
    def scan
      n = 0
      current_path = Dir.pwd
      Pathname.new(current_path).children.each do |dir|
        begin
          m = MovieBot::MovieFolder.new(dir.realpath)
          m.imdb
          n = n+1
        rescue Exception => e
          puts e
        end
      end
      puts "Movie found:\t#{n}"
    end
  end
end