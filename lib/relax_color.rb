# frozen_string_literal: true

# Core module loader
module Relax
  require_relative './relax-patches/relax_patches.rb'
  require_relative './relax-errors/relax_errors.rb'
  require_relative './relax-color/colorspace.rb'
  require_relative './relax-color/color.rb'
end
