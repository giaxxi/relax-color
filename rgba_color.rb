require_relative './rgb_to_hsl.rb'

class RgbaColor
  include RgbToHsl

  MAX = 255
  MIN = 0

  attr_reader :r, :g, :b, :a

  def initialize(rgba)
    r,g,b,a = rgba.split(',')
    @r = Integer(r)
    @g = Integer(g)
    @b = Integer(b)
    @a = (Float(a) if a) || 1
    raise 'Malformed RGB color' unless self.valid?
  end

  def valid?
    [r,g,b].none? { |ch| ch < MIN || ch > MAX} && (0.0..1.0).include?(a)
  end

  def to_a
    [r,g,b,a] 
  end

  def to_html
    rgba = to_a.join(',')
    ['rgba(', rgba, ')'].join
  end

  def transparent?
    a < 1
  end

  def dark?
    [r,g,b].any?{ |ch| ch < 128 }
  end

  def to_hex
    hex = [r,g,b].map{ |e| e.to_i.to_s(16).rjust(2, '0') }.join
  end

end

# rgba = RgbaColor.new('255,210,210')
# p rgba
# p rgba.to_a
# p rgba.to_html
# p rgba.transparent?
# p rgba.dark?
# p rgba.to_hex