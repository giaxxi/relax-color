# frozen_string_literal: true

spec.required_ruby_version = '>= 2.5.0'

files = Dir['lib/relax-color.rb', 'lib/*/*.*', 'lib/*/*/*.*']
# files.each { |f| p f }

Gem::Specification.new do |s|
  s.name        = 'relax-color'
  s.version     = '0.0.1'
  s.date        = '2020-02-15'
  s.summary     = 'Just a personal tool'
  s.description = 'Converts color spaces and more'
  s.authors     = ['iGian']
  s.email       = ''
  s.files       = files
  s.homepage    = 'https://github.com/giaxxi/relax-color'
  s.license     = 'MIT'
end
