path = "./spec/fixtures/movies/with_subdirectory"
describe MovieBot::MovieFolder do
  include MovieBot
  
  before(:all) do
    @movie = MovieFolder.new(path)
    @sample_file = %w{annie.hall.bluray.1977.sample.mkv annie.hall.SaMpLe.mkv}
    @movie_file = %w{annie.hall.bluray.1977.mkv}
  end
  
  it "should raise an error if it contains subdirectory" do
    lambda {@movie}.should raise_error(BadFolderStructure)
  end
end
