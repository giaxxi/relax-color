require_relative './color'

color = Color::RGBA.new(10,20,30)
p color

color = Color.new('#121210', :hex)
p color.class
p color.color.class
p color.to_rgba.color.to_html


color = Color.new('200,120,20', :rgba)
p color.class
p color.color.to_html
p color.to_hex.color.to_html

p color.color.h
p color.color.s
p color.color.l