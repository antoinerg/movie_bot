require 'movie_bot'

path = "./spec/fixtures/Annie Hall (1977)"
describe MovieBot::MovieFolder do
  include MovieBot
  it "should point to an existing folder" do
    lambda {MovieFolder.new("not_existing")}.should raise_error(ArgumentError)
  end

  it "should return nfos" do
    m = MovieFolder.new(path)
    puts m.nfos
    m.nfos.size.should eq(2)
  end

  it "should return imdb id from movie.nfo" do
    m = MovieFolder.new(path)
    m.imdb.should eq("tt0075686")
  end

  it "should raise an error if it contains subdirectory" do
    lambda {MovieFolder.new(path)}.should_not raise_error(StandardError)
  end
  
  it "should return the video file it contains" do
    m = MovieFolder.new(path)
    m.video.first.basename.to_s.should eq("annie.hall.bluray.1977.mkv") 
  end 
end
