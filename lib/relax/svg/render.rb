# frozen_string_literal: true

module Relax
  module SVG
    # Common methods for adding children to a
    # conatainer or to an image
    module Render
      # Renders the container returning
      # a String of xml script chunk
      module RenderContainer
        def render
          attributes = self.class::ATTRIBUTES.map do |var|
            value = instance_eval var.to_s
            "#{var.to_svg_attribute}=\"#{value}\"" if value
          end.compact.join(' ')
          [
            Relax::SVG::Render
              .structural_tag_opening(self.class::NAME, attributes),
            children_values,
            Relax::SVG::Render.structural_tag_closing(self.class::NAME)
          ].join
        end
      end

      # Renders the graphic element returning
      # a String of xml script chunk
      module RenderGraphic
        def render
          attributes = instance_variables.map do |var|
            value = instance_eval var.to_s
            "#{var.to_svg_attribute}=\"#{value}\""
          end.compact.join(' ')
          Relax::SVG::Render.graphic_tag(self.class::NAME, attributes)
        end
      end

      # To-do maybe move into a Tag module?
      def self.graphic_tag(name, attributes)
        "<#{name} #{attributes}/>"
      end

      def self.structural_tag_opening(name, attributes)
        "<#{name} #{attributes}>"
      end

      def self.structural_tag_closing(name)
        "</#{name}>"
      end
    end
  end
end
