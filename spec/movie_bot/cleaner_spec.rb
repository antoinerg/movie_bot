require 'spec_helper'
path = File.join(File.dirname(__FILE__),"fixtures/movies/clean")
destination = '/tmp'

describe MovieBot::Cleaner do
  include MovieBot
  
  before(:each) do
    Fileutils.cp_r path, destination
    @cleaner = Cleaner.new(File.join(destination,'clean'))
  end

  after(:each) do
    Fileutils.rm_r path
  end

  it "should return a imdb" do
    @cleaner.movie.imdb.should eq("tt0075686")
  end
  
  it "folder should be renamed to a normalized name" do
    @cleaner.rename_folder!
  end
end
