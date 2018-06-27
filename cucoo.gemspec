# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cucoo/version'

Gem::Specification.new do |spec|
  spec.name = 'cucoo'
  spec.version = Cucoo::VERSION
  spec.authors = ['RC']
  spec.email = ['rc.chandru@gmail.com']
  spec.summary = %q{Cucumber steps and assertions for testing your APIs}
  spec.description = %q{This gem offers a DSL on top of webmock, cucumber and json_spec to make testing APIs on rails easier}
  spec.homepage = 'https://github.com/rcdexta/cucoo'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'json_spec'
  spec.add_dependency 'capybara'
  spec.add_dependency 'webmock'
  spec.add_dependency 'rspec-rails', '~> 3.0'
  spec.add_dependency 'cucumber-rails'
  spec.add_dependency 'selenium-webdriver'
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'puma'
end
