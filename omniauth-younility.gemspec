# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/younility/version'

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-younility'
  spec.version       = Omniauth::Younility::VERSION
  spec.authors       = ['Chris Cameron', 'Paul Robertson', 'Farrukh Abdulkadyrov']
  spec.email         = ['unchris@outlook.com', 't.paulrobertson@gmail.com', 'farrukhabdul@gmail.com']
  spec.summary       = %q{ OmniAuth strategy for Younility. }
  spec.description   = %q{ OmniAuth strategy for Younility. }
  spec.homepage      = 'https://github.com/YounilityInc/omniauth-younility'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock'

  spec.add_dependency 'omniauth', '~> 1.6.1'
  spec.add_dependency 'omniauth-oauth2', '~> 1.3.1'
end
