
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "arctic/ui/version"

Gem::Specification.new do |spec|
  spec.name          = "arctic-ui"
  spec.version       = Arctic::UI::VERSION
  spec.authors       = ["Emil Kampp"]
  spec.email         = ["emil@kampp.me"]

  spec.summary       = "Interact with the Arctic e-shop core API"
  spec.description   = <<~STR
    This is a wrapper for http interactions with the Arctic e-shop core API,
    allowing to easily send the arctic api compatible json to the core API.
  STR
  spec.homepage      = "https://youweaps.github.io/arctic-gems-ui"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", '~> 3.3'
  spec.add_development_dependency "vcr", '~> 4.0'
  spec.add_development_dependency "pry", '~> 0.11'

  spec.add_runtime_dependency 'activesupport', '~> 5.1'
  spec.add_runtime_dependency 'faraday', '< 0.13'
  spec.add_runtime_dependency 'faraday_middleware-parse_oj', '~> 0.3.2'
  spec.add_runtime_dependency 'faraday_middleware', '~> 0.12'
  spec.add_runtime_dependency 'faraday-detailed_logger', '~> 2.1'
  spec.add_runtime_dependency 'oauth2', '~> 1.4'
  spec.add_runtime_dependency 'faraday-http-cache', '~> 2.0'
end
