# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'facebook_chat/version'

Gem::Specification.new do |spec|
  spec.name          = "facebook_chat"
  spec.version       = FacebookChat::VERSION
  spec.authors       = ["Kengo Tateishi"]
  spec.email         = ["embrace.ddd.flake.peace@gmail.com"]
  spec.description   = %q{Facebook Chat API Client}
  spec.summary       = %q{Facebook Chat API Client}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", "~> 1.3"
  spec.add_dependency "rake"
  spec.add_dependency "xmpp4r"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
end
