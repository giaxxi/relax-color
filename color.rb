require_relative './rgba_color.rb'
require_relative './hsv_color.rb'
require_relative './hex_color.rb'

class Color
  COLOR_ENCODINGS = [:hsl, :rgba, :hex]

  attr_reader :color

  def initialize(color, type)
    raise "Not a valid color encoding" unless COLOR_ENCODINGS.include? type
    @color = RgbaColor.new(color) if type == :rgba
    @color = HexColor.new(color) if type == :hex
    raise 'Not implemented' if type == :hsv
  end

  def to_hex
    return self if color.class == HexColor
    return Color.new(color.to_hex, :hex) if color.class == RgbaColor
  end

  def to_rgba
    return self if color.class == RgbaColor
    return Color.new(color.to_rgba, :rgba) if color.class == HexColor
  end

  module RGBA
    def self.new(r, g, b, a=1)
      Color.new([r,g,b,a].join(','), :rgba)
    end
  end

end
