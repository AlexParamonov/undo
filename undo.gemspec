# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "undo"
  spec.version       = IO.read("VERSION")
  spec.authors       = ["Alexander Paramonov"]
  spec.email         = ["alexander.n.paramonov@gmail.com"]
  spec.summary       = %q{Reverts operation made upon object}
  spec.description   = %q{
Undo reverts operation made upon object.
It stores the object state before the mutator operation and allows to restore this state later.

Undo uses adapters for storage (Redis, ActiveRecord, etc) and custom serializers (ActiveRecord, Virtus, etc).
It is very lightweight solution that can be used as well with heavy ActiveRecord as with simple Hash or Virtus objects.
No database required: store data as it suites you.
}
  spec.homepage      = "http://github.com/AlexParamonov/undo"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "virtus", "~> 1.0"
  spec.add_development_dependency 'bundler', '~> 1.0'
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0.0.beta1"
end
