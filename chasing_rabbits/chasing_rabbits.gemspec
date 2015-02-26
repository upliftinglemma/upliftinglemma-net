$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "chasing_rabbits/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "chasing_rabbits"
  s.version     = ChasingRabbits::VERSION
  s.authors     = ["TODO: Write your name"]
  s.email       = ["TODO: Write your email address"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ChasingRabbits."
  s.description = "TODO: Description of ChasingRabbits."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"

  s.add_development_dependency "pg"
end
