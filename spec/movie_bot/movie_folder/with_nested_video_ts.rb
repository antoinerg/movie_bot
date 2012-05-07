path = "./spec/fixtures/movies/with_nested_video_ts"
describe MovieBot::MovieFolder do
  before(:all) do
    @movie = MovieBot::MovieFolder.new(path)
    @movie_files = %w{VIDEO_TS}
  end
  
  it "should return the video file it contains" do
    @movie.video_files.collect{|f| f.path.basename.to_s}.should =~ @movie_files
  end
  
  it "should be a dvd" do
    @movie.movie_files.first.dvd?.should eq(true)
  end
  
  it "should be a dvd folder" do
    @movie.movie_files.first.is_dvd_folder?.should eq(true)
  end
end
