# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'VcrToCurl/version'

Gem::Specification.new do |spec|
  spec.name          = "VcrToCurl"
  spec.version       = VcrToCurl::VERSION
  spec.authors       = ["Yan Lhert"]
  spec.email         = ["info@yanlhert.com"]
  spec.summary       = %q{Turn VCR cassettes into curl commands}
  spec.description   = %q{This gem allows you to take a vcr
    cassette and turn it into a curl command}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
