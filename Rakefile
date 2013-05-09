#!/usr/bin/env rake

###########
## Bundler

begin
  require 'bundler/setup'
rescue LoadError => e
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
  raise e
end

########
## rdoc

begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rake/rdoctask'
  RDoc::Task = Rake::RDocTask
end

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Stachio'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

#########
## RSpec

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError => e
  puts "Rspec couldn't be found, try running bundle install"
  raise e
end

###################
## Everything else

APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

Bundler::GemHelper.install_tasks
task :default => [:spec]
