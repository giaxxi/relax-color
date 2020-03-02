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
        def initialize
          yield self
        end

        def add_children(children = [])
          raise Relax::Errors::SVG::MustBeAnArray unless children.is_a? Array

          yield children
          feed(children)
        end

        def feed(children)
          children.each_with_index do |value, i|
            instance_variable_set "@children_#{i}", value
          end
        end

        def render
          attributes =  self.class::ATTRIBUTES
                        .each_with_object([]) do |var, res|
                          value = instance_eval var.to_s
                          res << "#{var.to_svg_attribute}=\"#{value}\"" if value
                        end.join(' ')
          [
            Relax::SVG.structural_tag_opening(self.class::NAME, attributes),
            children_values,
            Relax::SVG.structural_tag_closing(self.class::NAME)
          ].join
        end

        private

        def children_method_names
          instance_variables - self.class::ATTRIBUTES.map(&:to_instance_var)
        end

        def children_values
          children_method_names
            .map { |method_name| instance_eval(method_name.to_s) }.join
        end
      end
    end
  end
end
