path = "./spec/fixtures/movies/with_subdirectory"
describe MovieBot::MovieFolder do
  include MovieBot
  
  before(:all) do
    @movie = MovieFolder.new(path)
    @sample_files = %w{annie.hall.bluray.1977.sample.mkv annie.hall.SaMpLe.mkv}
    @movie_files = %w{annie.hall.bluray.1977.mkv}
  end
  
  it "should return list of directories" do
    @movie.directories.first.basename.to_s.should eq ("covers")
  end
  
  it "should raise an error if it contains subdirectory when normalized?" do
    lambda {@movie.normalized?}.should raise_error(BadFolderStructure)
  end
end
