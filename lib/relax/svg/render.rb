# frozen_string_literal: true

module Relax
  module SVG
    # Common methods for adding children to a
    # conatainer or to an image
    module Render
      # Renders the container
      # building the xml script chunk
      module RenderContainer
        def render
          attributes = self.class::ATTRIBUTES.map do |var|
            value = instance_eval var.to_s
            "#{var.to_svg_attribute}=\"#{value}\"" if value
          end.compact.join(' ')
          [
            Relax::SVG.structural_tag_opening(self.class::NAME, attributes),
            children_values,
            Relax::SVG.structural_tag_closing(self.class::NAME)
          ].join
        end
      end

      # Renders the graphic element
      # building the xml script chunk
      module RenderGraphic
        def render
          attributes = instance_variables.map do |var|
            value = instance_eval var.to_s
            "#{var.to_svg_attribute}=\"#{value}\""
          end.compact.join(' ')
          Relax::SVG.graphic_tag(self.class::NAME, attributes)
        end
      end
    end
  end
end
