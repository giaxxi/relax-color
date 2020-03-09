# frozen_string_literal: true

module Relax
  # Helper methods for validating data
  module Validator
    # Helper methods for validating data on SVG module
    module SVG
      # point = [x, y]
      def validate_point(point)
        valid_point = valid_point_array(point) && valid_pairs(point)
        raise Relax::Errors::SVG::InvalidPoint unless valid_point

        true
      end

      private

      def valid_point_array(point)
        point.is_a?(Array) && point.size == 2
      end

      def valid_pairs(point)
        point.all? { |e| e.is_a?(Integer) || e.is_a?(Float) }
      end
    end
  end
end
