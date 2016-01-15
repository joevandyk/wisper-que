# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wisper/que/version'

Gem::Specification.new do |spec|
  spec.name          = "wisper-que"
  spec.version       = Wisper::Que::VERSION
  spec.authors       = ["Joe Van Dyk"]
  spec.email         = ["joevandyk@gmail.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.summary       = %q{wisper adapter for que}
  spec.description   = %q{hooks que up to wisper}
  spec.homepage      = "https://github.com/joevandyk/wisper-que"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "que", "~> 0.11"
  spec.add_dependency "wisper", "~> 1.0"

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
