path = "./spec/fixtures/movies/with_samples"
describe MovieBot::MovieFolder do
  include MovieBot
  
  before(:all) do
    @movie = MovieFolder.new(path)
    @sample_file = %w{annie.hall.bluray.1977.sample.mkv annie.hall.SaMpLe.mkv}
    @movie_file = %w{annie.hall.bluray.1977.mkv}
  end
  
  it "should return the video file it contains" do
    @movie.video.collect{|f| f.path.basename.to_s}.should =~ @sample_file + @movie_file
  end 
  
  it "should return the samples" do
    @movie.sample.collect{|s| s.basename.to_s }.should eq(@sample_file)
  end
end
