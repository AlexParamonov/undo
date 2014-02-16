# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'undo/gemspec'

Gem::Specification.new do |spec|
  spec.name          = "undo"
  spec.version       = Undo::VERSION
  spec.authors       = ["Alexander Paramonov"]
  spec.email         = ["alexander.n.paramonov@gmail.com"]
  spec.summary       = %q{Undo operations on object}
  spec.description   = %q{Reverts last operation on the object}
  spec.homepage      = "http://github.com/AlexParamonov/undo"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "virtus", "~> 1.0"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0.0.beta1"

  if Undo::RUNNING_ON_CI
    spec.add_development_dependency "coveralls"
  else
    spec.add_development_dependency "pry"
    spec.add_development_dependency "pry-plus" if "ruby" == RUBY_ENGINE
  end
end
