# frozen_string_literal: true

files = Dir[
            'lib/relax-color.rb',
            'lib/relax.rb',
            'lib/*/*.*',
            'lib/*/*/*.*'
        ]

Gem::Specification.new do |s|
  s.name        = 'relax-color'
  s.version     = '0.0.2'
  s.date        = '2020-02-29'
  s.summary     = 'Just a personal tool'
  s.description = 'Converts color spaces and more'
  s.authors     = ['iGian']
  s.email       = ''
  s.files       = files
  s.homepage    = 'https://github.com/giaxxi/relax-color'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 2.6.3'
end
