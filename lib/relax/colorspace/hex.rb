# frozen_string_literal: true

module Relax
  module ColorSpace
    # Class for RGB colorspace in hex notation
    class Hex
      attr_reader :hex

      def initialize(hex)
        @hex = hex.to_s.delete_prefix('#')
        valid?
      end

      def to_s
        hex
      end

      def to_a
        hex.chars.each_slice(2).map(&:join)
      end

      def to_h
        %i[red green blue].zip(to_a).to_h
      end

      def to_html
        hex.prepend '#'
      end

      def to_rgba
        hex.chars
           .each_slice(2)
           .map { |ee| ee.unshift('0x').join.to_i(16) } << 1.0
      end

      def to_rgba_hash
        %i[red green blue alpha].zip(to_rgba).to_h
      end

      def to_hsl
        raise Relax::Errors::Hex::NotImplemented
      end

      private

      def valid?
        raise Relax::Errors::Hex::StringMustBeSixChars if hex.size != 6
        raise Relax::Errors::Hex::InvalidChars unless valid_chars?

        true
      end

      def valid_chars?
        hex.chars.all? { |ch| [*'0'..'9', *'a'..'f'].include?(ch) }
      end
    end
  end
end
