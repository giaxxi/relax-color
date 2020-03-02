# frozen_string_literal: true

module Relax
  module SVG
    module Container
      # Structural element as defined by
      # https://www.w3.org/TR/SVG2/struct.html#SVGElement
      class Svg < ContainerPrototype
        NAME = 'svg'
        XMLNS_ATTRIBUTE = [:xmlns].freeze
        GEOMETRY_ATTRIBUTES = %i[x y width height].freeze
        SPECIFIC_ATTRIBUTES = %i[
          view__box
          preserve__aspect__ratio
          zoom__and__pan transform
        ].freeze
        ATTRIBUTES = (
          XMLNS_ATTRIBUTE +
          GEOMETRY_ATTRIBUTES +
          SPECIFIC_ATTRIBUTES +
          Relax::SVG::Container::ATTRIBUTES
        ).freeze

        attr_accessor :xmlns, *ATTRIBUTES

        def initialize
          @xmlns = Relax::SVG::XMLNS
          super
        end

        def save_minified(filename)
          File.open(filename, 'w') { |f| f.write render + "\n" }
        end

        def save_xml(filename)
          raise 'missing Nokogiri' unless Relax::SVG::NOKOGIRI

          content = Nokogiri::XML render
          File.open(filename, 'w') { |f| f.write content.to_xml }
        end

        def save_html(filename)
          raise 'missing Nokogiri' unless Relax::SVG::NOKOGIRI

          content = Nokogiri::HTML render
          File.open(filename, 'w') { |f| f.write content.to_xhtml }
        end
      end
    end
  end
end
