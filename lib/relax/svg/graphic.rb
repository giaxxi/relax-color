# frozen_string_literal: true

module Relax
  module SVG
    module Graphic
      PRESENTATION_ATTRIBUTES = [:fill].freeze

      # Prototype Graphic object as defined by
      # https://www.w3.org/TR/SVG2/struct.html#TermGraphicsElement
      class GraphicPrototype
        include Relax::SVG::Render::RenderGraphic

        def initialize
          yield self
        end

        def self.list_geometry_attributes
          self::GEOMETRY_ATTRIBUTES.map(&:to_svg_attribute)
        end
      end
    end
  end
end
