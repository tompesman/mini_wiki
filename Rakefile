require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the mini_wiki plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.test_files = FileList["#{File.dirname(__FILE__)}/test/*.rb"]
  #t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the mini_wiki plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'MiniWiki'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'rcov/rcovtask'
  desc 'Output test coverage of plugin.'
  Rcov::RcovTask.new(:coverage) do |t|
    t.libs << "lib"
    t.libs << "generators"
    t.libs << "test"
    t.test_files = FileList["#{File.dirname(__FILE__)}/test/*.rb"]
#    t.pattern    = 'test/**/*_test.rb'
    t.output_dir = "#{File.dirname(__FILE__)}/test/coverage"
    t.verbose = true
    t.rcov_opts << '--rails --include "lib/*" --exclude "gem/*"'
  end
rescue
  # no rcov installed
end
