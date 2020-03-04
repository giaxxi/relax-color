# frozen_string_literal: true

module Relax
  module SVG
    # Main structural container element as defined by
    # https://www.w3.org/TR/SVG2/struct.html#SVGElement
    # Inherits from Relax::SVG::Container::Svg
    # It has methods for saving as a file
    # It can't contain na objecto f the same class
    class Image
      NAME = 'svg'
      XMLNS_ATTRIBUTE = [:xmlns].freeze
      PRESENTATION_ATTRIBUTES = [:fill].freeze
      GEOMETRY_ATTRIBUTES = %i[x y width height].freeze
      SPECIFIC_ATTRIBUTES = %i[
        view__box
        preserve__aspect__ratio
        zoom__and__pan transform
      ].freeze
      ATTRIBUTES = (
        XMLNS_ATTRIBUTE +
        PRESENTATION_ATTRIBUTES +
        GEOMETRY_ATTRIBUTES +
        SPECIFIC_ATTRIBUTES +
        Relax::SVG::PRESENTATION_ATTRIBUTES +
        Relax::SVG::CORE_ATTRIBUTES
      ).freeze

      include Relax::SVG::Children
      include Relax::SVG::Render::RenderContainer
      attr_accessor :xmlns, *ATTRIBUTES

      def initialize
        @xmlns = Relax::SVG::XMLNS
        yield self
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
