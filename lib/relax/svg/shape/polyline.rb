# frozen_string_literal: true

module Relax
  module SVG
    module Shape
      # Line object as defined by
      # https://www.w3.org/TR/SVG2/shapes.html#LineElement
      class Polyline < ShapePrototype
        NAME = 'polyline'
        GEOMETRY_ATTRIBUTES = %i[points].freeze
        ATTRIBUTES = (
          GEOMETRY_ATTRIBUTES +
          Relax::SVG::Shape::ATTRIBUTES
        ).freeze
        InvalidPoints = Relax::Errors::SVG::InvalidPoints

        attr_accessor(*ATTRIBUTES)

        def initialize
          @fill = 'none'
          @stroke_width = 1
          super
        end

        def points=(points)
          error_msg = 'Polyline points must be an array of arrays ' \
                      'of integers or floats pairs like ' \
                      '[[0, 0], [10, 20], ...]'
          raise InvalidPoints, error_msg unless valid_points(points)

          @points = points.map do |pair|
            pair.map { |n| n.round(4) }.join(',')
          end.join(' ')
        end

        private

        def valid_points(points)
          points.is_a?(Array) && points.all? { |pair| valid(pair) }
        end

        def valid(pair)
          array_of_pairs?(pair) && all_numbers?(pair)
        end

        def array_of_pairs?(pair)
          pair.is_a?(Array) && pair.size == 2
        end

        def all_numbers?(pair)
          pair.all? { |e| e.is_a?(Integer) || e.is_a?(Float) }
        end
      end
    end
  end
end
