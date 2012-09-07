# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gmail-utils/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ollivier Robert"]
  gem.email         = ["roberto@keltia.net"]
  gem.description   = %q{A few utilities to deal with mail, gmvault and others}
  gem.summary       = %q{Set of utilities to del with mail}
  gem.homepage      = ""

  gem.files         = `/usr/local/bin/hg locate`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "gmail-utils"
  gem.require_paths = ["lib"]
  gem.version       = GMail::Utils::VERSION

  gem.add_dependency "rake"
  gem.add_dependency "maildir"
  gem.add_dependency "mail"
  gem.add_dependency "rspec"
end
