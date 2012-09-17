#!/usr/bin/env rake
#
# $Id: Rakefile,v 22b3299fb1c2 2012/09/17 16:15:05 roberto $

require "bundler/gem_tasks"

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

desc "Report code statistics (KLOCs, etc) from the application"
task :stats do
  require './rake/code_statistics'
  CodeStatistics.new(
      ["Code", "lib"],
      ["Units", "spec"]
  ).to_s
end

desc "Sync the changesets to both central & bitbucket repos"
task :push do
  system "/usr/local/bin/hg push"
  system "/usr/local/bin/hg push ~/Dropbox/HG/gmail-utils"
  system "/usr/local/bin/hg push ssh://hg@bitbucket.org/keltia/gmail-utils"
end
