# -*- encoding: utf-8 -*-
require File.expand_path('../lib/podcast_press/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mitch Lloyd"]
  gem.email         = ["mitch.lloyd@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "podcast_press"
  gem.require_paths = ["lib"]
  gem.version       = PodcastPress::VERSION

  gem.add_dependency "taglib-ruby", "~> 0.5.0"
end
