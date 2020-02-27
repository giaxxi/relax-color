# frozen_string_literal: true

module Relax
  # Patches for the standard String class
  module String
    def numeric?
      Float(self)
      true
    rescue ArgumentError
      false
    end
  end
end

String.include Relax::String
