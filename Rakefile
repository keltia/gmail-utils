#!/usr/bin/env rake
#
# $Id: Rakefile,v 1681b2e2f64c 2012/09/07 13:49:53 roberto $

require "bundler/gem_tasks"

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
