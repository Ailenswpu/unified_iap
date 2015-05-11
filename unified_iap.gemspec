# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'unified_iap/version'

Gem::Specification.new do |spec|
  spec.name          = "unified_iap"
  spec.version       = UnifiedIap::VERSION
  spec.authors       = ["Ailenswpu"]
  spec.email         = ["renkaiswpu@gmail.com"]
  spec.summary       = %q{iap order veify service for googleplay and amazon and ios}
  spec.description   = %q{iap order veify service for googleplay and amazon and ios}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_runtime_dependency "google-api-client"
  spec.add_runtime_dependency "venice"
end