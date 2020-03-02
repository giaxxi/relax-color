# frozen_string_literal: true

module Relax
  # Core functionality of relax-color
  class Color
    COLOR_ENCODINGS = %i[hsla rgba hex].freeze

    attr_reader :rgba, :hsla, :cmyk

    def initialize(type, args)
      case type
      when :rgba
        init_rgba(args[:r], args[:g], args[:b], args[:a])
      when :hsla
        init_hsl(args[:h], args[:s], args[:l], args[:a])
      else
        raise Relax::Errors::Color::InvalidColorspace
      end
    end

    def self.rgba(red, green, blue, alpha = 1)
      Relax::Color.new(:rgba, r: red, g: green, b: blue, a: alpha)
    end

    def self.hsla(hue, saturation, lightness, alpha = 1)
      Relax::Color.new(:hsla, h: hue, s: saturation, l: lightness, a: alpha)
    end

    # sets rgba channels and updates hsla channels
    def rgba_to(args)
      rgba.send :change_to, args
      hsla.send :change_to, rgba.to_hsla_hash
    end

    # sets hsla channels and updates rgba channels
    def hsla_to(args)
      hsla.send :change_to, args
      rgba.send :change_to, hsla.to_rgba_hash
    end

    # returns a the Hex colorspace
    def to_hex
      Relax::Hex.new(rgba.to_hex)
    end

    private

    def init_rgba(red, green, blue, alpha)
      @rgba = Relax::Rgba.new(red, green, blue, alpha)
      @hsla = Relax::Hsla.new(*rgba.to_hsla)
    end

    def init_hsl(hue, saturation, lightness, alpha)
      @hsla = Relax::Hsla.new(hue, saturation, lightness, alpha)
      @rgba = Relax::Rgba.new(*hsla.to_rgba)
    end
  end
end
