require 'spec_helper'
path = File.join(File.dirname(__FILE__),"fixtures/movies/clean")

describe MovieBot::Cleaner do
  include FakeFS::SpecHelpers
  include MovieBot
  
  before(:all) do
    @cleaner = Cleaner.new(path)
  end

  it "should return a imdb" do
    @cleaner.movie.imdb.should eq("tt0075686")
  end
  
  it "folder should be renamed to a normalized name" do
    @cleaner.rename_folder!
  end
end