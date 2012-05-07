path = "./spec/fixtures/movies/with_samples"
describe MovieBot::MovieFolder do
  before(:all) do
    @movie = MovieBot::MovieFolder.new(path)
    @sample_files = %w{annie.hall.bluray.1977.sample.mkv annie.hall.SaMpLe.mkv}
    @movie_files = %w{annie.hall.bluray.1977.mkv}
  end
  
  it "should return all the video files it contains" do
    @movie.video_files.collect{|f| f.path.basename.to_s}.should =~ @sample_files + @movie_files
  end 
  
  it "should return the movie file" do
    @movie.movie_files.collect{|s| s.path.basename.to_s }.should eq(@movie_files)
  end
  
  it "should return the samples" do
    @movie.sample_files.collect{|s| s.path.basename.to_s }.should =~ @sample_files
  end
end
