require 'movie_bot'

def read_fixture(path)
  File.read(File.expand_path(File.join(File.dirname(__FILE__), "fixtures/imdb", path)))
end

IMDB_SAMPLES = { 
  "http://akas.imdb.com/title/tt0075686/combined" => "tt0075686"
}

unless ENV['LIVE_TEST']
  begin
    require 'fakeweb'
    
    FakeWeb.allow_net_connect = false
    IMDB_SAMPLES.each do |url, response|
      FakeWeb.register_uri(:get, url, :response => read_fixture(response))
    end
  rescue LoadError
    puts "Could not load FakeWeb, these tests will hit IMDB.com"
    puts "You can run `gem install fakeweb` to stub out the responses."
  end
end
