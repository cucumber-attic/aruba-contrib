# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aruba/contrib/version'

Gem::Specification.new do |spec|
  spec.name          = 'aruba-contrib'
  spec.version       = Aruba::Contrib::VERSION
  spec.authors       = ['Dennis Günnewig']
  spec.email         = ['dev@fedux.org']

  spec.summary       = %q{Additional steps/API methods for 'aruba'}
  spec.description   = %q{This gem contains all steps/API methods which might be valueable for the 'aruba'-community, but should be not part of 'aruba'-core}
  spec.homepage      = 'https://github.com/cucumber/aruba-contrib'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
