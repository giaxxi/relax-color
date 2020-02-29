# frozen_string_literal: true

# Namespacing
module Relax
  # Namespacing
  module ColorSpace
  end
end

require_relative './colorspace/rgb_to_hsl.rb'
require_relative './colorspace/hsl_to_rgb.rb'
require_relative './colorspace/hsla.rb'
require_relative './colorspace/rgba.rb'
require_relative './colorspace/hex.rb'
