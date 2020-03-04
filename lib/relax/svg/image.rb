# frozen_string_literal: true

module Relax
  module SVG
    # Main structural container element as defined by
    # https://www.w3.org/TR/SVG2/struct.html#SVGElement
    # Inherits from Relax::SVG::Container::Svg
    # It has methods for saving as a file
    # It can't contain na objecto f the same class
    class Image < Relax::SVG::Container::Svg
      NAME = 'svg'
      XMLNS_ATTRIBUTE = [:xmlns].freeze
      ATTRIBUTES = (
        XMLNS_ATTRIBUTE +
        Relax::SVG::Container::Svg::ATTRIBUTES
      ).freeze

      attr_accessor :xmlns, *ATTRIBUTES

      def initialize
        @xmlns = Relax::SVG::XMLNS
        super
      end

      def save_minified(filename)
        File.open(filename, 'w') { |f| f.write render + "\n" }
      end

      def to_xml
        content = Relax::SVG::XML.new render
        content.to_xml
      end

      def save_to_xml(filename)
        File.open(filename, 'w') { |f| f.write to_xml }
      end
    end
  end
end
