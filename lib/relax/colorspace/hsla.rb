# frozen_string_literal: true

module Relax
  module ColorSpace
    # Hue, saturation, lightness colorspace class
    class Hsla
      include HslToRgb

      ChannelsOutOfRange = Relax::Errors::Hsla::ChannelsOutOfRange
      MIN = 0
      H_MAX = 360.0
      S_MAX = 100.0
      L_MAX = 100.0

      attr_reader :h, :s, :l, :a

      def initialize(hue, saturation, lightness, alpha = 1.0)
        @h = Integer(hue)
        @s = Integer(saturation)
        @l = Integer(lightness)
        @a = (Float(alpha) if alpha).round(2) || 1.0
        raise ChannelsOutOfRange unless channels_in_range?
      end

      def change_to(args)
        change_hue_to args[:hue] if args[:hue]
        change_saturation_to args[:saturation] if args[:saturation]
        change_lightness_to args[:lightness] if args[:lightness]
        change_alpha_to args[:alpha] if args[:alpha]
      end

      def to_s
        to_a.join(', ')
      end

      def to_a
        [h, s, l, a]
      end

      def to_h
        { h: h, s: s, l: l, a: a }
      end

      def to_hex
        raise Relax::Errors::Hsla::NotImplemented
      end

      def to_relative
        [@h / H_MAX, @s / S_MAX, @l / L_MAX]
          .map { |e| e.round(5) }.join(',')
      end

      def to_relax_color
        Relax::Color.hsla(h, s, l, a)
      end

      protected

      def change_hue_to(hue)
        hue = Integer(hue)
        raise ChannelsOutOfRange unless hue_in_range? hue

        @h = hue
        true
      end

      def change_saturation_to(saturation)
        saturation = Integer(saturation)
        raise ChannelsOutOfRange unless saturation_in_range? saturation

        @s = saturation
        true
      end

      def change_lightness_to(lightness)
        lightness = Integer(lightness)
        raise ChannelsOutOfRange unless lightness_in_range? lightness

        @l = lightness
        true
      end

      def change_alpha_to(alpha)
        alpha = Float(alpha).round(2)
        raise ChannelsOutOfRange unless alpha_in_range? alpha

        @a = alpha
        true
      end

      def channels_in_range?
        [
          hue_in_range?(h),
          saturation_in_range?(s),
          lightness_in_range?(l),
          alpha_in_range?(a)
        ].all?
      end

      def hue_in_range?(hue)
        (MIN..H_MAX).include? hue
      end

      def saturation_in_range?(saturation)
        (MIN..S_MAX).include? saturation
      end

      def lightness_in_range?(lightness)
        (MIN..L_MAX).include? lightness
      end

      def alpha_in_range?(alpha)
        (0.0..1.0).include?(alpha)
      end
    end
  end
end
