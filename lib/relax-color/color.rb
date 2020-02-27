# frozen_string_literal: true

module Relax
  # Core functionality of relax-color
  class Color
    COLOR_ENCODINGS = %i[hsl rgba hex].freeze

    attr_reader :colorspace

    def initialize(type, args)
      case type
      when :rgba
        init_rgba(args[:r], args[:g], args[:b], args[:a])
      when :hsl
        init_hsl(args[:h], args[:s], args[:l])
      when :hex
        @colorspace = ColorSpace::Hex.new(args)
      else
        raise 'Not a valid color encoding'
      end
    end

    def init_rgba(red, green, blue, alpha)
      @colorspace = ColorSpace::Rgba.new(red, green, blue, alpha)
    end

    def init_hsl(hue, saturation, lightness)
      @colorspace = ColorSpace::Hsl.new(hue, saturation, lightness)
    end

    def self.rgba(red, green, blue, alpha = 1)
      Relax::Color.new(:rgba, r: red, g: green, b: blue, a: alpha)
    end

    def self.hex(hex_string)
      Relax::Color.new(:hex, hex_string)
    end

    def self.hsl(hue, saturation, lightness)
      Relax::Color.new(:hsl, h: hue, s: saturation, l: lightness)
    end

    def to_hsl
      if colorspace.is_a? ColorSpace::Hsl
        self
      elsif colorspace.is_a? ColorSpace::Rgba
        Relax::Color.new(:hsl, colorspace.to_hsl_hash)
      else
        raise Relax::Errors::Color::NotImplemented
      end
    end

    def to_hex
      return self if colorspace.is_a? ColorSpace::Hex

      # if colorspace.class == ColorSpace::Rgba
      Relax::Color.new(:hex, colorspace.to_hex)
    end

    def to_rgba
      return self if colorspace.is_a? ColorSpace::Rgba

      # if colorspace.class == ColorSpace::Hex
      Relax::Color.new(:rgba, colorspace.to_rgba_hash)
    end

    # sintactic sugar Relax::Color::RGB.new(red, gree, blue, alpha)
    module RGBA
      def self.new(red, green, blue, alpha = 1)
        Relax::Color.rgba(red, green, blue, alpha)
      end
    end

    # sintactic sugar Relax::Color::HSL.new(hue, saturation, lightness)
    module HSL
      def self.new(hue, saturation, lightness)
        Relax::Color.hsl(hue, saturation, lightness)
      end
    end

    # sintactic sugar Relax::Color::HEX.new(hex_string)
    module HEX
      def self.new(hex_string)
        Relax::Color.hex(hex_string)
      end
    end
  end
end
