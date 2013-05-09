# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gmail/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Ollivier Robert']
  gem.email         = ['roberto@keltia.net']
  gem.description   = %q{A few utilities to deal with GMail, gmvault and others}
  gem.summary       = %q{Set of utilities to deal with GMail}
  gem.homepage      = ''

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.name          = 'gmail-utils'
  gem.require_paths = ['lib']
  gem.version       = GMail::Utils::VERSION

  gem.add_dependency 'rake'
  gem.add_dependency 'maildir'
  gem.add_dependency 'mail'
  gem.add_dependency 'rspec'
  gem.add_dependency 'ffi'
  gem.add_dependency 'rufus-tokyo'
end
