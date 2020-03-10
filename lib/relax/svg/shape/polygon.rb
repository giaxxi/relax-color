# frozen_string_literal: true

module Relax
  module SVG
    module Shape
      # Line object as defined by
      # https://www.w3.org/TR/SVG2/shapes.html#LineElement
      class Polygon < ShapePrototype
        NAME = 'polygon'
        GEOMETRY_ATTRIBUTES = %i[points].freeze
        ATTRIBUTES = (
          GEOMETRY_ATTRIBUTES +
          Relax::SVG::Shape::ATTRIBUTES
        ).freeze
        InvalidPoints = Relax::Errors::SVG::InvalidPoints

        include Relax::Validator::SVG
        attr_accessor(*ATTRIBUTES)

        def initialize
          @fill = 'red'
          @stroke = 'black'
          @stroke_width = 1
          super
        end

        def points=(points)
          error_msg = 'Polygon points must be an array of arrays ' \
            'of integers or floats pairs like: [[0, 0], [10, 20], ...]'
          raise InvalidPoints, error_msg unless valid_points(points)

          @points = points.map do |pair|
            pair.map { |n| n }.join(',')
          end.join(' ')
        end

        private

        def valid_points(points)
          points.is_a?(Array) && points.all? { |point| validate_point(point) }
        end
      end
    end
  end
end
