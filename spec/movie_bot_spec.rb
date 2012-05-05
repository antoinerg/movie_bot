require 'movie_bot'

path = "./spec/fixtures/movies/Annie Hall (1977)"
describe MovieBot::MovieFolder do
  include MovieBot
  
  before(:all) do
    @movie = MovieFolder.new(path)
  end
  
  #subject { @movie }
  #specify { @movie.nfos.size.should eq(2)}
  
  it "should point to an existing folder" do
    lambda {MovieFolder.new("not_existing")}.should raise_error(ArgumentError)
  end

  it "should return nfos" do
    @movie.nfos.size.should eq(2)
  end

  it "should return imdb id from nfo" do
    @movie.imdb.should eq("tt0075686")
  end
  
  it "should raise an error if it contains subdirectory" do
    lambda {@movie}.should_not raise_error(StandardError)
  end
  
  it "should return the video file it contains" do
    @movie.video.first.file.basename.to_s.should eq("annie.hall.bluray.1977.mkv") 
  end 
  
  it "should return the samples" do
    @movie.sample.collect{|s| s.basename.to_s }.should eq(%w{annie.hall.bluray.1977.sample.mkv annie.hall.SaMpLe.mkv})
  end
end
