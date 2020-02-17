class Relax::Color
  COLOR_ENCODINGS = [:hsl, :rgba, :hex]

  attr_reader :color

  def initialize(color, type)
    raise "Not a valid color encoding" unless COLOR_ENCODINGS.include? type
    @color = ColorSpace::Rgba.new(color) if type == :rgba
    @color = HexColor.new(color) if type == :hex
    @color = ColorSpace::Hsl.new(color) if type == :hsl
  end

  def to_hex
    return self if color.class == HexColor
    return Color.new(color.to_hex, :hex) if color.class == RgbaColor
  end

  def to_rgba
    return self if color.class == RgbaColor
    return Color.new(color.to_rgba, :rgba) if color.class == HexColor
  end

  def self.rgba(r, g, b, a=1)
    Relax::Color.new([r,g,b,a].join(','), :rgba)
  end

  def self.hex(hex_string)
    Relax::Color.new(hex_string, :hex)
  end

  def self.hsl(h, s, l)
    Relax::Color.new([h,s,l].join(','), :hsl)
  end

  module RGBA
    def self.new(r, g, b, a=1)
      Relax::Color.rgba(r, g, b, a)
    end
  end

  module HSL
    def self.new(h, s, l)
      Relax::Color.hsl(h,s,l)
    end
  end

  module HEX
    def self.new(hex_string)
      Color.hex(hex_string)
    end
  end

end
