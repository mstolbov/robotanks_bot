# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'robotanks_bot/version'

Gem::Specification.new do |gem|
  gem.name          = "robotanks_bot"
  gem.version       = RobotanksBot::VERSION
  gem.authors       = ["Mikhail Stolbov"]
  gem.email         = ["mstolbov@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency('multi_json')
  gem.add_runtime_dependency('celluloid')
  gem.add_runtime_dependency('celluloid-io')
end
