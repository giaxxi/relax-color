# frozen_string_literal: true

module Relax
  module SVG
    module Graphic
      # Rectangle object as defined by
      # https://www.w3.org/TR/SVG2/shapes.html#RectElement
      class Circle < GraphicPrototype
        NAME = 'circle'
        GEOMETRY_ATTRIBUTES = %i[cx cy r].freeze
        ATTRIBUTES = (
          Relax::SVG::CORE_ATTRIBUTES +
          Relax::SVG::PRESENTATION_ATTRIBUTES +
          Relax::SVG::Graphic::PRESENTATION_ATTRIBUTES +
          GEOMETRY_ATTRIBUTES
        ).freeze

        attr_accessor(*ATTRIBUTES)
      end
    end
  end
end
