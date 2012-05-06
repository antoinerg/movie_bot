path = "./spec/fixtures/movies/clean"
describe MovieBot::MovieFolder do
  include MovieBot
  
  before(:all) do
    @movie = MovieFolder.new(path)
    @sample_files = []
    @movie_files = %w{annie.hall.bluray.1977.mkv}
  end
  
  it "should point to an existing folder" do
    lambda {MovieFolder.new("not_existing")}.should raise_error(ArgumentError)
  end

  it "should return nfos" do
    @movie.nfos.size.should eq(2)
  end

  it "should return imdb id from nfo" do
    @movie.imdb.should eq("tt0075686")
  end
  
  it "should return the movie file" do
    @movie.movie_files.collect{|s| s.path.basename.to_s}.should eq(@movie_files)
  end 
  
  it "should return the samples" do
    @movie.sample_files.collect{|s| s.path.basename.to_s }.should eq(@sample_files)
  end
end
