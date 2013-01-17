path = "spec/fixtures/movies/without_nfo"
describe MovieBot::MovieFolder do
  before(:all) do
    @movie = MovieBot::MovieFolder.new(path)
    @movie_files = %w{annie.hall.bluray.1977.mkv}
  end
  
  it "should return the video file it contains" do
    @movie.video_files.collect{|f| f.path.basename.to_s}.should =~ @movie_files
  end
  
  it "should not return any nfos" do
    @movie.nfos.should eq(nil)
  end

  it "should not return an imdb id" do
    expect {@movie.imdb}.to raise_error MovieBot::ImdbIDNotFound
  end
end
