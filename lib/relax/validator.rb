# frozen_string_literal: true

module Relax
  # Helper methods for validating data
  module Validator
    # Helper methods for validating data on SVG module
    module SVG
      InvalidPoints = Relax::Errors::SVG::InvalidPoints
      InvalidPoint = Relax::Errors::SVG::InvalidPoint

      # call as validate_points(points, point.size)
      # when there is no limit to points (e.g. polygon)
      def validate_points(points, nr_ = nil)
        raise Relax::Errors::SVG::MissingPointsNumber unless nr_

        return validate_point(points) if nr_ == 1

        raise InvalidPoints unless valid_points?(points, nr_)

        points
      end

      # point = [x, y]
      def validate_point(point)
        valid_point = valid_point_array(point) && valid_pairs(point)
        raise InvalidPoint unless valid_point

        point
      end

      private

      def valid_points?(points, nr_)
        [
          points.is_a?(Array),
          (points.size == nr_),
          points.all? { |point| validate_point(point) }
        ].all?
      end

      def valid_point_array(point)
        point.is_a?(Array) && point.size == 2
      end

      def valid_pairs(point)
        point.all? { |e| e.is_a?(Integer) || e.is_a?(Float) }
      end
    end
  end
end
