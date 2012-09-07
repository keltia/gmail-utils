#!/usr/bin/env rake
#
# $Id: Rakefile,v 5fcec21f0593 2012/09/07 13:57:20 roberto $

require "bundler/gem_tasks"
Bundler::GemHelper.install_tasks

require 'rake'
require 'rake/testtask'
require 'rspec/core/rake_task'

desc "Run basic specs"
RSpec::Core::RakeTask.new(:test_specs) do |t|
  t.pattern = 'spec/**/*.rb'
  t.rspec_opts = '--format documentation'
  t.rcov_opts =  %q[--exclude "spec"]
  t.rcov = false
end

desc "Sync the changesets to both central & bitbucket repos"
task :push do
  system "/usr/local/bin/hg push"
  system "/usr/local/bin/hg push ssh://hg@bitbucket.org/keltia/gmail-utils"
end
