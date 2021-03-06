# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "movie_bot/version"

Gem::Specification.new do |s|
  s.name        = "movie_bot"
  s.version     = MovieBot::VERSION
  s.authors     = ["antoine"]
  s.email       = ["roygobeil.antoine@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Opiniated bot to manage movie collections}
  s.description = %q{Helps you renaming,cleaning and normalizing your movie folders}

  s.rubyforge_project = "movie_bot"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_development_dependency "fakeweb"
  s.add_dependency "configuration"
  s.add_dependency "imdb"
  s.add_dependency "thor"
  s.add_dependency "mediainfo"
  #s.add_dependency "xbmc_library"
end
