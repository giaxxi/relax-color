# frozen_string_literal: true

module Relax
  module SVG
    module Graphic
      # Rectangle object as defined by
      # https://www.w3.org/TR/SVG2/shapes.html#RectElement
      class Rect < GraphicPrototype
        NAME = 'rect'
        GEOMETRY_ATTRIBUTES = %i[x y width height rx ry].freeze
        ATTRIBUTES = (
          Relax::SVG::CORE_ATTRIBUTES +
          Relax::SVG::PRESENTATION_ATTRIBUTES +
          Relax::SVG::Graphic::PRESENTATION_ATTRIBUTES +
          GEOMETRY_ATTRIBUTES
        ).freeze

        attr_accessor(*ATTRIBUTES)

        def render
          attributes =  instance_variables
                        .each_with_object([]) do |var, res|
                          value = instance_eval var.to_s
                          res << "#{var.to_svg_attribute}=\"#{value}\""
                        end.join(' ')
          Relax::SVG.graphic_tag(NAME, attributes)
        end
      end
    end
  end
end
