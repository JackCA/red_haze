# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "red_haze/version"

Gem::Specification.new do |s|
  s.name        = "red_haze"
  s.version     = RedHaze::VERSION
  s.authors     = ["Jack Anderson"]
  s.email       = ["jackcanderson@gmail.com"]
  s.homepage    = "https://github.com/JackCA/red_haze"
  s.summary     = "a Ruby wrapper for the Soundcloud API"

  s.rubyforge_project = "red_haze"
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "webmock"
  s.add_development_dependency "vcr"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_dependency 'httparty'
  s.add_dependency 'multi_json'

end
