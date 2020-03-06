# frozen_string_literal: true

module Relax
  module SVG
    # Structural objects under this module, as defined
    # https://www.w3.org/TR/SVG2/struct.html#TermStructuralElement
    module Structural
      # This is a prototype class for a structural element
      class StructuralPrototype
        include Relax::SVG::Render::RenderContainer
        include Relax::SVG::Children

        def initialize
          yield self if block_given?
        end
      end
    end
  end
end
