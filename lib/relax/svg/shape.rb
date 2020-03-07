# frozen_string_literal: true

module Relax
  module SVG
    module Shape
      # Prototype Graphic object as defined by
      # https://www.w3.org/TR/SVG2/struct.html#TermGraphicsElement
      class ShapePrototype
        # include Relax::SVG::Render::RenderGraphic
        include Relax::SVG::Render::RenderContainer
        include Relax::SVG::Children

        def initialize
          yield self if block_given?
        end

        def self.list_geometry_attributes
          self::GEOMETRY_ATTRIBUTES.map(&:to_svg_attribute)
        end
      end
    end
  end
end
