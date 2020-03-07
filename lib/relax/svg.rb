# frozen_string_literal: true

# To-do: make a header file with all constant
# definition for all the elements
module Relax
  # This module helps generating
  # an svg image founded on
  # https://www.w3.org/TR/SVG2/
  module SVG
    XMLNS = 'http://www.w3.org/2000/svg'
    CORE_ATTRIBUTES = %i[
      element_id
      tabindex
      lang
      xml_space
      element_class
      element_style
    ].freeze
    # fill is a common attribute except for animation elements,
    # therefore is not included in the following list
    PRESENTATION_ATTRIBUTES = %i[
      alignment_baseline
      baseline_shift
      clip_path
      clip_rule
      color
      color_interpolation
      color_interpolation_filters
      color_rendering
      cursor
      direction
      display
      dominant_baseline
      fill_opacity
      fill_rule
      filter
      flood_color
      flood_opacity
      font_family
      font_size
      font_size_adjust
      font_stretch
      font_style
      font_variant
      font_weight
      glyph_orientation_horizontal
      glyph_orientation_vertical
      image_rendering
      letter_spacing
      lighting_color
      marker_end
      marker_mid
      marker_start
      mask
      opacity
      overflow
      paint_order
      pointer_events
      shape_rendering
      stop_color
      stop_opacity
      stroke
      stroke_dasharray
      stroke_dashoffset
      stroke_linecap
      stroke_linejoin
      stroke_miterlimit
      stroke_opacity
      stroke_width
      text_anchor
      text_decoration
      text_overflow
      text_rendering
      unicode_bidi
      vector_effect
      visibility
      white_space
      word_spacing
      writing_mode
    ].freeze

    module Structural
      PRESENTATION_ATTRIBUTES = [:fill].freeze
      ATTRIBUTES = (
        PRESENTATION_ATTRIBUTES +
        Relax::SVG::PRESENTATION_ATTRIBUTES +
        Relax::SVG::CORE_ATTRIBUTES
      ).freeze
    end

    module Shape
      PRESENTATION_ATTRIBUTES = [:fill].freeze
      ATTRIBUTES = (
        PRESENTATION_ATTRIBUTES +
        Relax::SVG::CORE_ATTRIBUTES +
        Relax::SVG::PRESENTATION_ATTRIBUTES
      ).freeze
    end
  end
end

# require_relative './patches.rb'
require_relative './svg/render.rb'
require_relative './svg/children.rb'
require_relative './svg/image.rb'
require_relative './svg/structural.rb'
require_relative './svg/shape.rb'
require_relative './svg/never_rendered.rb'
require_relative './svg/xml.rb'
require_relative './svg/structural/defs.rb'
require_relative './svg/structural/group.rb'
require_relative './svg/structural/svg.rb'
require_relative './svg/shape/rect.rb'
require_relative './svg/shape/circle.rb'
