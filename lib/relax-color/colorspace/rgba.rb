# frozen_string_literal: true

module ColorSpace
  # Red, green blue colorspace class
  class Rgba
    include RgbToHsl

    ChannelsOutOfRange = Relax::Errors::Rgba::ChannelsOutOfRange
    MAX = 255
    MIN = 0

    attr_reader :r, :g, :b, :a

    def initialize(red, green, blue, alpha = 1.0)
      @r = Integer(red)
      @g = Integer(green)
      @b = Integer(blue)
      @a = (Float(alpha) if alpha).round(2) || 1.0
      validate_channels
    end

    def change_to(args)
      change_red_to args[:red] if args[:red]
      change_green_to args[:green] if args[:green]
      change_blue_to args[:blue] if args[:blue]
      change_alpha_to args[:alpha] if args[:alpha]
    end

    def to_s
      to_a.join(',')
    end

    def to_a
      [r, g, b, a]
    end

    def to_h
      { r: r, g: g, b: b, a: a }
    end

    def to_html
      rgba = to_s
      ['rgba(', rgba, ')'].join
    end

    def opaque!
      if a < 1
        @a = 1.0
        return true
      end
      false
    end

    def opaque
      return ColorSpace::Rgba.new(r, g, b) if a < 1

      self
    end

    def transparent?
      a < 1
    end

    def dark?
      lightness <= 50
    end

    def light?
      lightness > 50
    end

    def to_relative
      [r, g, b].map { |e| (e.fdiv MAX).round(5) }
    end

    def to_hex
      [r, g, b].map { |e| e.to_i.to_s(16).rjust(2, '0') }.join
    end

    def to_html_hex
      to_hex.prepend '#'
    end

    def to_relax_color
      Relax::Color.rgba(r, g, b, a)
    end

    private

    def change_red_to(red)
      red = Integer(red)
      raise ChannelsOutOfRange if rgb_out_of_range? red

      @r = red
      true
    end

    def change_green_to(green)
      green = Integer(green)
      raise ChannelsOutOfRange if rgb_out_of_range? green

      @g = green
      true
    end

    def change_blue_to(blue)
      blue = Integer(blue)
      raise ChannelsOutOfRange if rgb_out_of_range? blue

      @b = blue
      true
    end

    def change_alpha_to(alpha)
      alpha = Float(alpha).round(2)
      raise ChannelsOutOfRange unless alpha_in_range? alpha

      @a = alpha
      true
    end

    def rgb_out_of_range?(channel)
      channel < MIN || channel > MAX
    end

    def alpha_in_range?(alpha)
      (0.0..1.0).include?(alpha)
    end

    def valid_range?
      [r, g, b].none? { |ch| rgb_out_of_range?(ch) } && alpha_in_range?(a)
    end

    def validate_channels
      raise ChannelsOutOfRange unless valid_range?
    end
  end
end
