# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/unreleased_changelog/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-unreleased_changelog'
  spec.version       = Fastlane::UnreleasedChangelog::VERSION
  spec.author        = 'Manish Rathi'
  spec.email         = 'manishrathi19902013@gmail.com'

  spec.summary       = 'A fastlane plugin to manage unreleased changelog using a YAML file. 🚀'
  spec.homepage       = "https://github.com/crazymanish/fastlane-plugin-unreleased_changelog"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency('pry')
  spec.add_development_dependency('bundler')
  spec.add_development_dependency('rspec')
  spec.add_development_dependency('rspec_junit_formatter')
  spec.add_development_dependency('rake')
  spec.add_development_dependency('rubocop', '0.49.1')
  spec.add_development_dependency('rubocop-require_tools')
  spec.add_development_dependency('simplecov')
  spec.add_development_dependency('fastlane', '>= 2.146.1')
end
