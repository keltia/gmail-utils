#!/usr/bin/env rake
#
# $Id: Rakefile,v e65c392e811d 2012/09/05 12:13:46 roberto $

require "bundler/gem_tasks"

desc "Sync the changesets to both central & bitbucket repos"
task :push do
  system "/usr/local/bin/hg push"
  system "/usr/local/bin/hg push ssh://hg@bitbucket.org/keltia/gmail-utils"
end
