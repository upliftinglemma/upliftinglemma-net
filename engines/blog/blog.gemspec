$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "blog/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "blog"
  s.version     = Blog::VERSION
  s.authors     = ["Chris Bouchard"]
  s.email       = ["chris@upliftinglemma.net"]
  s.homepage    = "http://upliftinglemma.net"
  s.summary     = "A blog engine for Uplfting Lemma"
  s.description = "A blog engine for Uplfting Lemma"
  s.license     = "BSD"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "draper"

  s.add_development_dependency "pg"
end
