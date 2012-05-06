path = "./spec/fixtures/movies/with_video_ts"
describe MovieBot::MovieFolder do
  include MovieBot
  
  before(:all) do
    @movie = MovieFolder.new(path)
    @movie_file = %w{VIDEO_TS}
  end
  
  it "should raise an error if it contains subdirectory" do
    lambda {@movie}.should_not raise_error(StandardError)
  end
  
  it "should return the video file it contains" do
    @movie.video.collect{|f| f.path.basename.to_s}.should =~ @movie_file
  end
end
