# frozen_string_literal: true

module Relax
  # Rgba class for Relax module
  # private change_to
  # for avoiding internal inconsistency between
  # Relax::Rgba and Relax::Hsl
  class Rgba < Relax::ColorSpace::Rgba
    private

    def change_to(args)
      super
    end
  end

  # Hsl class for the Relax module
  # private change_to
  # for avoiding internal inconsistency between
  # Relax::Rgba and Relax::Hsl
  class Hsla < Relax::ColorSpace::Hsla
    private

    def change_to(args)
      super
    end
  end

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

    def rgba_to(args)
      rgba.send :change_to, args
      hsla.send :change_to, rgba.to_hsla_hash
    end

    def hsla_to(args)
      hsla.send :change_to, args
      rgba.send :change_to, hsla.to_rgba_hash
    end

    # sintactic sugar Relax::Color::RGB.new(red, gree, blue, alpha)
    module RGBA
      def self.new(red, green, blue, alpha = 1)
        Relax::Color.rgba(red, green, blue, alpha)
      end
    end

    # sintactic sugar Relax::Color::HSL.new(hue, saturation, lightness)
    module HSLA
      def self.new(hue, saturation, lightness, alpha)
        Relax::Color.hsla(hue, saturation, lightness, alpha)
      end
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
