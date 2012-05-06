require 'movie_bot'
require 'fakefs'

path = "./spec/fixtures/movies/clean"
describe MovieBot::Cleaner do
  include FakeFS::SpecHelpers
  include MovieBot

  before(:all) do
    @cleaner = Cleaner.new(path)
    @sample_files = %w{annie.hall.bluray.1977.sample.mkv annie.hall.SaMpLe.mkv}
    @movie_files = %w{annie.hall.bluray.1977.mkv}
  end
  
  it "should rename folder based IMDB information" do
    @cleaner.rename_folder!
    assert File.directory?('./spec/fixtures/movies/Annie Hall (1977)')
  end
end