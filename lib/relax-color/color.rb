# frozen_string_literal: true

module Relax
  # Rgba class for Relax module
  # private change_to
  # for avoiding internal inconsistency between
  # Relax::Rgba and Relax::Hsl
  class Rgba < ColorSpace::Rgba
    private

    def change_to(args)
      super
    end
  end

  # Hsl class for the Relax module
  # private change_to
  # for avoiding internal inconsistency between
  # Relax::Rgba and Relax::Hsl
  class Hsl < ColorSpace::Hsl
    private

    def change_to(args)
      super
    end
  end

  # Core functionality of relax-color
  class Color
    COLOR_ENCODINGS = %i[hsl rgba hex].freeze

    attr_reader :rgba, :hsl, :cmyk

    def initialize(type, args)
      case type
      when :rgba
        init_rgba(args[:r], args[:g], args[:b], args[:a])
      when :hsl
        init_hsl(args[:h], args[:s], args[:l])
      else
        raise Relax::Errors::Color::InvalidColorspace
      end
    end

    def self.rgba(red, green, blue, alpha = 1)
      Relax::Color.new(:rgba, r: red, g: green, b: blue, a: alpha)
    end

    def self.hsl(hue, saturation, lightness)
      Relax::Color.new(:hsl, h: hue, s: saturation, l: lightness)
    end

    def rgba_to(args)
      rgba.send :change_to, args
      hsl.send :change_to, rgba.to_hsl_hash
    end

    def hsl_to(args)
      hsl.send :change_to, args
      rgba.send :change_to, hsl.to_rgba_hash
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

    private

    def init_rgba(red, green, blue, alpha)
      @rgba = Relax::Rgba.new(red, green, blue, alpha)
      @hsl = Relax::Hsl.new(*rgba.to_hsl)
    end

    def init_hsl(hue, saturation, lightness)
      @hsl = Relax::Hsl.new(hue, saturation, lightness)
      @rgba = Relax::Rgba.new(*hsl.to_rgba)
    end
  end
end
