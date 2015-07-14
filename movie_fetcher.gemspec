# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'movie_fetcher/version'

Gem::Specification.new do |spec|
  spec.name          = "movie_fetcher"
  spec.version       = MovieFetcher::VERSION
  spec.authors       = ["Rafał Lisowski"]
  spec.email         = ["lisukorin@gmail.com"]

  spec.summary       = %q{The next film shows in Warsaw.}
  spec.description   = %q{The next film shows in Warsaw.}
  spec.homepage      = "https://github.com/korin/movie_fetcher"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "timecop"
end
