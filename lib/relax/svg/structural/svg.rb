# frozen_string_literal: true

module Relax
  module SVG
    module Structural
      # Structural element as defined by
      # https://www.w3.org/TR/SVG2/struct.html#SVGElement
      class Svg < Relax::SVG::Structural::StructuralPrototype
        NAME = 'svg'
        GEOMETRY_ATTRIBUTES = %i[x y width height].freeze
        SPECIFIC_ATTRIBUTES = %i[
          view__box
          preserve__aspect__ratio
          zoom__and__pan transform
        ].freeze
        ATTRIBUTES = (
          GEOMETRY_ATTRIBUTES +
          SPECIFIC_ATTRIBUTES +
          Relax::SVG::Structural::ATTRIBUTES
        ).freeze

        attr_accessor(*ATTRIBUTES)
      end
    end
  end
end
