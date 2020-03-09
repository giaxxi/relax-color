# frozen_string_literal: true

module Relax
  module SVG
    module Shape
      # Ellipse object as defined by
      # https://www.w3.org/TR/SVG2/shapes.html#EllipseElement
      class Ellipse < ShapePrototype
        NAME = 'ellipse'
        GEOMETRY_ATTRIBUTES = %i[cx cy rx ry].freeze
        ATTRIBUTES = (
          GEOMETRY_ATTRIBUTES +
          Relax::SVG::Shape::ATTRIBUTES
        ).freeze

        attr_accessor(*ATTRIBUTES)
      end
    end
  end
end
