path = "./spec/fixtures/movies/without_nfo"
describe MovieBot::MovieFolder do
  include MovieBot
  
  before(:all) do
    @movie = MovieFolder.new(path)
    @movie_files = %w{annie.hall.bluray.1977.mkv}
  end
  
  it "should return the video file it contains" do
    @movie.video_files.collect{|f| f.path.basename.to_s}.should =~ @movie_files
  end
  
  it "should raise an error when normalized?" do
    lambda {@movie.normalized?}.should raise_error(NfoNotFound)
  end
  
  it "should not return an imdb id" do
    @movie.imdb.should eq(nil)
  end
end
