
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "arctic/core/version"

Gem::Specification.new do |spec|
  spec.name          = "arctic-core"
  spec.version       = Arctic::Core::VERSION
  spec.authors       = ["Emil Kampp"]
  spec.email         = ["emil@kampp.me"]

  spec.summary       = "Interact with the Arctic e-shop core API"
  spec.description   = <<~STR
    This is a wrapper for http interactions with the Arctic e-shop core API,
    allowing to easily send the arctic api compatible json to the core API.
  STR
  spec.homepage      = "https://github.com/YouWeApS/arctic-gems-core-api"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock"

  spec.add_runtime_dependency 'activesupport', '~> 5.1'
  spec.add_runtime_dependency 'faraday', '~> 0.14'
  spec.add_runtime_dependency 'faraday_middleware-parse_oj', '~> 0.3.2'
  spec.add_runtime_dependency 'faraday_middleware'
  spec.add_runtime_dependency 'faraday-detailed_logger'
end
