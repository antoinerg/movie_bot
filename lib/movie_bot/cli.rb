require 'movie_bot'
require 'thor'

module MovieBot
  class CLI < Thor
    desc "scan", "Scan current folder"
    def scan
      n = 0
      current_path = Dir.pwd
      Pathname.new(current_path).children.each do |dir|
        puts "#{dir.basename}\n"
        puts "--------"
        begin
          m = MovieBot::MovieFolder.new(dir.realpath)
          puts "IMDB id : #{m.imdb}"
          puts "Sample : #{m.sample}"
          info = m.video.first.info
          puts "Resolution: #{info.video.width}x#{info.video.height}"
          puts "Overall bitrate: #{info.overall_bit_rate}"
          n = n+1
        rescue Exception => e
          puts "#{e}"
        end
        puts "\n"
      end
      puts "------\nCleaned movie folder found:\t#{n}"
    end
  end
end