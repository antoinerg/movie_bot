require 'movie_bot'

Dir[File.join(File.dirname(__FILE__),'/movie_folder/*.rb')].each {|f| require f}