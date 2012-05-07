require 'movie_bot'
require 'thor'

module MovieBot
  class CLI < Thor
    desc "clean", "Clean movie folder"
    def clean(path)
      MovieBot::Cleaner.new(path)      
    end
    
    desc "scan", "Scan current folder"
    def scan(path='.')
      n = 0
      Pathname.new(path).children.each do |dir|
        puts "#{dir.basename}\n"
        puts "--------"
        begin
          m = MovieBot::MovieFolder.new(dir.realpath)
          puts "IMDB id : #{m.imdb}"
          puts "Sample files: #{m.sample_files}"
          puts "Movie files: #{m.movie_files}"
          info = m.movie_files.first.info
          puts "Resolution: #{info.video.width}x#{info.video.height}"
          puts "Overall bitrate: #{info.overall_bit_rate}"
          n = n+1
        rescue Exception => e
          puts e
        end
        puts "\n"
      end
      puts "------\nCleaned movie folder found:\t#{n}"
    end
  end
end