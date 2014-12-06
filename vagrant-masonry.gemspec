$LOAD_PATH << File.expand_path(File.join('..', 'lib'), __FILE__)
require 'config_builder/version'

Gem::Specification.new do |gem|
  gem.name    = 'vagrant-masonry'
  gem.version = ConfigBuilder::VERSION

  gem.summary     = 'Generate Vagrant configurations from arbitrary data'
  gem.description = 'Use YAML configuration files to declaratively specify Vagrant configuration.'

  gem.authors  = ['Jozef Izso', 'Adrien Thebo']
  gem.email    = ['jozef.izso@gmail.com', 'adrien@somethingsinistral.net']
  gem.homepage = 'https://github.com/goitsk/vagrant-masonry'

  gem.has_rdoc = true
  gem.license  = 'Apache 2.0'

  gem.files        = %x{git ls-files -z}.split("\0")
  gem.require_path = 'lib'

  gem.add_runtime_dependency 'deep_merge', '~> 1.0.0'

  gem.add_development_dependency 'rspec', '~> 2.14.0'
end
