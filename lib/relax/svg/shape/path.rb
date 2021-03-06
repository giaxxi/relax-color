# frozen_string_literal: true

module Relax
  module SVG
    module Shape
      # Line object as defined by
      # https://www.w3.org/TR/SVG2/shapes.html#LineElement
      class Path < ShapePrototype
        NAME = 'path'
        GEOMETRY_ATTRIBUTES = [:d].freeze
        ATTRIBUTES = (
          GEOMETRY_ATTRIBUTES +
          Relax::SVG::Shape::ATTRIBUTES
        ).freeze

        attr_accessor(*ATTRIBUTES)
      end
    end
  end
end
