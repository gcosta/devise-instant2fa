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

end
