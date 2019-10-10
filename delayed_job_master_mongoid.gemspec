# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'delayed/master/mongoid/version'

Gem::Specification.new do |spec|
  spec.name          = "delayed_job_master_mongoid"
  spec.version       = Delayed::Master::Mongoid::VERSION
  spec.authors       = ["Yoshikazu Kaneta"]
  spec.email         = ["kaneta@sitebridge.co.jp"]
  spec.summary       = %q{A mongoid adapter for delayed_job_master gem}
  spec.description   = %q{A mongoid adapter for delayed_job_master gem}
  spec.homepage      = "https://github.com/kanety/delayed_job_master_mongoid"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.3"

  spec.add_dependency "delayed_job_master", ">= 2.0"
  spec.add_dependency "delayed_job_mongoid", ">= 2.3"

  spec.add_development_dependency "rails"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "mongoid"
end
