# frozen_string_literal: true

module Relax
  module SVG
    module Container
      # Structural element as defined by
      # https://www.w3.org/TR/SVG2/struct.html#GElement
      class Group < ContainerPrototype
        NAME = 'g'
        GEOMETRY_ATTRIBUTES = %i[x y width height].freeze
        SPECIFIC_ATTRIBUTES = [:transform].freeze
        ATTRIBUTES = (
                      GEOMETRY_ATTRIBUTES +
                      SPECIFIC_ATTRIBUTES +
                      Relax::SVG::Container::ATTRIBUTES
                    ).freeze

        attr_accessor(*ATTRIBUTES)
      end
    end
  end
end
