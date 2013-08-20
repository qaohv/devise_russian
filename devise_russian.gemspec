# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'devise_russian/version'

Gem::Specification.new do |gem|
  gem.license       = "MIT"
  gem.name          = "devise_russian"
  gem.version       = DeviseRussian::VERSION
  gem.authors       = ["Andrey"]
  gem.email         = ["railscode@gmail.com"]
  gem.description   = "Часто используемые наработки по джему Devise. Включает решение по авторизации в социальных сетях"
  gem.summary       = "Часто используемые наработки по джему Devise. Включает решение по авторизации в социальных сетях"
  gem.homepage      = "https://github.com/st-granat/devise_russian"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "rails", ">= 2.3.12"
  gem.add_dependency "xss_terminate", ">= 0.2"
  gem.add_dependency "devise", ">= 2.2.3"
  gem.add_dependency "omniauth", ">= 1.1.3"
  gem.add_dependency "omniauth-oauth2", ">= 1.1.1"
  gem.add_dependency "useful_helpers", ">= 0.0.1"
end
