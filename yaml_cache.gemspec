lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "yaml_cache/version"

Gem::Specification.new do |spec|
  spec.name          = "yaml_cache"
  spec.version       = YamlCache::VERSION
  spec.authors       = ["Sean Ross Earle"]
  spec.email         = ["sean.earle@oeQuacki.com"]

  spec.summary       = %q{Store and cache data in a YAML file}
  spec.description   = %q{A simple gem for storing and caching data in a YAML file}
  spec.homepage      = "https://github.com/HellRok/YAMLCache"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
