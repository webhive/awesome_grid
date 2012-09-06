# -*- encoding: utf-8 -*-
require File.expand_path('../lib/awesome_grid/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Roman Tataurov"]
  gem.email         = ["tataurov@gmail.com"]
  gem.description   = %q{Easy way to build data grids}
  gem.summary       = %q{Easy way to build data grids}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "awesome_grid"
  gem.require_paths = ["lib"]
  gem.version       = AwesomeGrid::VERSION

  gem.add_dependency(%q<rails>, ["> 2.3.0"])
  gem.add_dependency(%q<rake>, ["> 0.8.7"])

  gem.add_development_dependency(%q<rspec-rails>, ["~> 1.3"])
  gem.add_development_dependency(%q<rspec_tag_matchers>, [">= 1.0.0"])
  gem.add_development_dependency("rspec2-rails-views-matchers", "~> 0.2.2")
  # gem.add_development_dependency("rspec", "~> 1.3.2")

  gem.add_development_dependency("bundler", ">= 1.0.0")
  gem.add_development_dependency("rspec", "~> 2.11.0")
  gem.add_development_dependency("gem-release")
end
