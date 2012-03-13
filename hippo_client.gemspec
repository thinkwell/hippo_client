# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "hippo_client/version"

Gem::Specification.new do |s|
  s.name        = "hippo_client"
  s.version     = HippoClient::VERSION
  s.authors     = ["Brandon Turner"]
  s.email       = ["bt@brandonturner.net"]
  s.homepage    = ""
  s.summary     = %q{Ruby bindings for accessing Hippo"}
  s.description = %q{Ruby bindings for accessing Hippo"}

  s.rubyforge_project = "hippo_client"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specifiy any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency(%q<john-hancock>, [">= 0.0.6", "< 0.1.0"])
  s.add_runtime_dependency %q<json>
  s.add_runtime_dependency %q<activesupport>

  s.add_development_dependency(%q<rspec>, [">= 2.7.0"])
  s.add_development_dependency(%q<bundler>, [">= 1.0.21"])
end
