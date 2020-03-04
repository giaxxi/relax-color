# frozen_string_literal: true

module Relax
  module SVG
    # Structural objects under this module, as defined
    # https://www.w3.org/TR/SVG2/struct.html#TermStructuralElement
    module Container
      PRESENTATION_ATTRIBUTES = [:fill].freeze
      ATTRIBUTES = (
                      PRESENTATION_ATTRIBUTES +
                      Relax::SVG::PRESENTATION_ATTRIBUTES +
                      Relax::SVG::CORE_ATTRIBUTES
                    ).freeze
      # This is a prototype class for a structural element
      class ContainerPrototype
        include Relax::SVG::Render::RenderContainer
        include Relax::SVG::Children

        def initialize
          yield self
        end
      end
    end
  end
end
