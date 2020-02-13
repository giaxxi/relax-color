require "test/unit/assertions"
require_relative './color'

include Test::Unit::Assertions


# test HEX
color = Color.new('#121210', :hex)
p color.class
p color.color.class
p color.to_rgba.color.to_html

# test RGBA
color = Color.new('200,120,20', :rgba)
p color.class
p color.color.to_html
p color.to_hex.color.to_html

color = Color::RGBA.new(10,20,30)
p color

p color.color.h
p color.color.s
p color.color.l

p rgba = RgbaColor.new('200,120,20,0.8').to_color

# test HSL
p hsl = HslColor.new('360,1,1')
p hsl = Color::HSL.new(360, 1, 1)
p hsl.color
p hsl.color.to_color

