require 'spec_helper'
path = "spec/fixtures/movies/clean"
destination = '/tmp/movie_bot'
final_destination = destination + '/final'

describe MovieBot::Cleaner do
  before(:each) do
    FileUtils.mkdir_p destination
    FileUtils.mkdir_p final_destination
    FileUtils.cp_r path, destination
    @cleaner = MovieBot::Cleaner.new(File.join(destination,'clean'))
  end

  after(:each) do
    FileUtils.rm_r destination
  end

  it "should read configuration" do
    #MovieBot::Cleaner::CONFIG.xbmc.database.username.should eq('xbmc')
  end
  
  it "should return a imdb" do
    @cleaner.movie.imdb.should eq("tt0075686")
  end
  
  it "should return a normalized name" do
    @cleaner.name.should eq ("Annie Hall (1977)")
  end
  
  it "folder should be renamed to a normalized name" do
    @cleaner.rename_folder!
    File.directory?(File.join(destination,'Annie Hall (1977)')).should be_true
  end

  it "should create movie.nfo" do
    imdb = 'tt0075686'
    @cleaner.imdb = imdb
    @cleaner.create_movie_nfo!
    Pathname(File.join(destination,'clean','movie.nfo')).read.should eq("http://www.imdb.com/title/#{imdb}/\n")
  end
  
  it "should move folder to final destination" do
    ENV['DEST_DIR'] = final_destination
    @cleaner.move_folder!
    File.directory?(File.join(final_destination,'clean')).should be_true
  end
  
  it "should clean release information" do
    t=MovieBot::Cleaner.title_clean("Rounders 1998 BluRay 1080p Dual x264 erz")
    t.should eq ("Rounders (1998)")
  end
end
