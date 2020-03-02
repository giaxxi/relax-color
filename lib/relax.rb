# frozen_string_literal: true

# Namespacing
module Relax
  # Rgba class for Relax module
  # method change_to set to private
  # so it is not possile to call change_to
  # Relax::Rgba and Relax::Hsl instances
  # for avoiding internal inconsistency
  # when changing channel values.
  # When setting a colorspace channel
  # other colorspaces of the same color
  # must be updated.
  class Rgba < Relax::ColorSpace::Rgba
    private

    def change_to(args)
      super
    end
  end

  # Rgba class for Relax module
  # method change_to set to private
  # so it is not possile to call change_to
  # Relax::Rgba and Relax::Hsl instances
  # for avoiding internal inconsistency
  # when changing channel values.
  # When setting a colorspace channel
  # other colorspaces of the same color
  # must be updated.
  class Hsla < Relax::ColorSpace::Hsla
    private

    def change_to(args)
      super
    end
  end

  # Relax:Hex for naming consistency
  class Hex < Relax::ColorSpace::Hex
  end
end
