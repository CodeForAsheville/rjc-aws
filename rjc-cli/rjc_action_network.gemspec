lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rjc_action_network/version'

Gem::Specification.new do |spec|
  spec.name          = "rjc_action_network"
  spec.version       = RjcActionNetwork::VERSION
  spec.authors       = ["agirlnamedsophia"]
  spec.email         = ["sophia.elizabeth.russell@gmail.com"]

  spec.summary       = "Small library to interact with RJC AN proxy"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6.5")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "hanami-cli", "~> 0.1"
  spec.add_dependency "faraday"
  spec.add_dependency "faraday_middleware"
  spec.add_dependency "tty-command"
  spec.add_dependency "zeitwerk"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
end
