# frozen_string_literal: true

module ColorSpace
  # Hue, saturation, lightness colorspace class
  class Hsl
    include HslToRgb

    MIN = 0
    H_MAX = 360
    S_MAX = 100
    L_MAX = 100

    attr_reader :hue, :saturation, :lightness

    def initialize(hue, saturation, lightness)
      @hue = Integer(hue)
      @saturation = Integer(saturation)
      @lightness = Integer(lightness)
      raise Relax::Errors::Hsl::ChannelsOutOfRange unless valid?
    end

    def to_s
      to_a.join(', ')
    end

    def to_a
      [hue, saturation, lightness]
    end

    def to_h
      { h: hue, s: saturation, l: lightness }
    end

    def to_hex
      raise Relax::Errors::Hsl::NotImplemented
    end

    def to_relative
      [@hue / 360.0, @saturation / 100.0, @lightness / 100.0]
        .map { |e| e.round(5) }.join(',')
    end

    def to_relax_color
      Relax::Color.hsl(hue, saturation, lightness)
    end

    protected

    def valid?
      h_valid? && s_valid? && l_valid?
    end

    def h_valid?
      (MIN..H_MAX).include? hue
    end

    def s_valid?
      (MIN..S_MAX).include? saturation
    end

    def l_valid?
      (MIN..L_MAX).include? lightness
    end
  end
end
