class Relax::Color
  COLOR_ENCODINGS = [:hsl, :rgba, :hex]

  attr_reader :colorspace

  def initialize(type, args)
    raise "Not a valid color encoding" unless COLOR_ENCODINGS.include? type
    @colorspace = ColorSpace::Rgba.new(args[:r], args[:g], args[:b], args[:a]) if type == :rgba
    @colorspace = ColorSpace::Hex.new(args) if type == :hex
    @colorspace = ColorSpace::Hsl.new(args[:h], args[:s], args[:l]) if type == :hsl
  end

  def self.rgba(r, g, b, a=1)
    Relax::Color.new(:rgba, r: r, g: g, b: b, a: a)
  end

  def self.hex(hex_string)
    Relax::Color.new(:hex, hex_string)
  end

  def self.hsl(h, s, l)
    Relax::Color.new(:hsl, h: h, s: s, l: l)
  end


  def to_hsl
    return self if colorspace.is_a? ColorSpace::Hsl
    return Relax::Color.new(:hsl, colorspace.to_hsl_hash) #if colorspace.class == ColorSpace::Rgba
  end

  def to_hex
    return self if colorspace.is_a? ColorSpace::Hex
    return Relax::Color.new(:hex, colorspace.to_hex) #if colorspace.class == ColorSpace::Rgba
  end

  def to_rgba
    return self if colorspace.is_a? ColorSpace::Rgba
    return Relax::Color.new(:rgba, colorspace.to_rgba_hash) #if colorspace.class == ColorSpace::Hex
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
