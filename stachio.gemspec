$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "stachio/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "stachio"
  s.version     = Stachio::VERSION
  s.authors     = ["Blake Thomas", "Enova Financial"]
  s.email       = ["bwthomas@gmail.com", "bthomas@enova.com"]
  s.homepage    = "https://github.com/bwthomas/stachio"
  s.summary     = "Stash your Stache with Stachio."
  s.description = "Stachio is a rails engine which aims to facilitate the creation, retrieval, update, & deletion of mustache templates in a relational database."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec}/*`.split("\n")

  s.add_dependency "rails", "~> 3.2.1"
  s.add_dependency "lookup_by"
  s.add_dependency "jquery-rails"           ## required by the dummy application
  s.add_dependency "stache"                 ## use mustache/handlebars for views
  s.add_dependency "mustache"
  s.add_dependency "handlebars"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rspec-fire"
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'simplecov-rcov'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'pry'
end
