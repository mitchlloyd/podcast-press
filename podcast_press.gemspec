# -*- encoding: utf-8 -*-
require File.expand_path('../lib/podcast_press/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mitch Lloyd"]
  gem.email         = ["mitch.lloyd@gmail.com"]
  gem.description   = "ID3-ify your podcast episodes"
  gem.summary       = "Appy ID3 tags to your podcast episodes"
  gem.homepage      = "https://github.com/mitchlloyd/podcast-press"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "podcast_press"
  gem.require_paths = ["lib"]
  gem.version       = PodcastPress::VERSION

  gem.add_dependency "taglib-ruby", "~> 0.5.0"
  gem.add_dependency "commander", "~> 4.1.2"
  gem.add_dependency "aws-s3", "~> 0.6.3"

  gem.add_development_dependency "debugger"
  gem.add_development_dependency "minitest-reporters"
end
