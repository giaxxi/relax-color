class Relax::Color
  COLOR_ENCODINGS = [:hsl, :rgba, :hex]

  attr_reader :colorspace

  def initialize(color, type)
    raise "Not a valid color encoding" unless COLOR_ENCODINGS.include? type
    @colorspace = ColorSpace::Rgba.new(color) if type == :rgba
    @colorspace = ColorSpace::Hex.new(color) if type == :hex
    @colorspace = ColorSpace::Hsl.new(color) if type == :hsl
  end

  def to_hsl
    return self if colorspace.is_a? ColorSpace::Hsl
    return Relax::Color.new(colorspace.to_hsl, :hsl) if colorspace.class == ColorSpace::Rgba
  end

  def to_hex
    return self if colorspace.is_a? ColorSpace::Hex
    return Relax::Color.new(colorspace.to_hex, :hex) if colorspace.class == ColorSpace::Rgba
  end

  def to_rgba
    return self if colorspace.class == ColorSpace::Rgba
    return Relax::Color.new(colorspace.to_rgba, :rgba) if colorspace.class == ColorSpace::Hex
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
      Relax::Color.hex(hex_string)
    end
  end

end
