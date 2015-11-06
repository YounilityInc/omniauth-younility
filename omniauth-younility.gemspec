# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/younility/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-younility"
  spec.version       = Omniauth::Younility::VERSION
  spec.authors       = ["Chris Cameron", "Paul Robertson", "Farrukh Abdulkadyrov"]
  spec.email         = ["unchris@outlook.com", "t.paulrobertson@gmail.com", "farrukhabdul@gmail.com"]
  spec.summary       = %q{ OmniAuth strategy for Younility. }
  spec.description   = %q{ OmniAuth strategy for Younility. }
  spec.homepage      = "https://github.com/YounilityInc/omniauth-younility"
  spec.name          = "omniauth-younility"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency("bundler", "~> 1.5")
  spec.add_development_dependency("rake")
  spec.add_development_dependency("rspec")
  spec.add_development_dependency("rack-test")
  spec.add_development_dependency("simplecov")
  spec.add_development_dependency("webmock")

  spec.add_dependency("byebug")

  spec.add_dependency("omniauth", "~> 1.0")
  spec.add_dependency("omniauth-oauth2", "~> 1.3.1")
end
