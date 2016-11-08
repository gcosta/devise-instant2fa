# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "devise_instant2fa/version"

Gem::Specification.new do |s|
  s.name        = "devise_instant2fa"
  s.version     = DeviseInstant2fa::VERSION.dup
  s.authors     = ["Jesse Pollak"]
  s.email       = ["jesse@instant2fa.com"]
  s.homepage    = "https://github.com/clef/instant2fa-devise"
  s.summary     = %q{Instant 2FA plugin for devise}

  s.rubyforge_project = "devise_instant2fa"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'rails', '>= 3.1.1'
  s.add_runtime_dependency 'devise'
  s.add_runtime_dependency 'instant2fa'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec-rails', '>= 3.0.1'
  s.add_development_dependency 'capybara', '2.4.1'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'timecop'
end
