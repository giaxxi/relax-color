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

  module SVG
    # Patches for the standard Symbol class
    # used in module SVG
    module Symbol
      def to_instance_var
        to_s.prepend('@').to_sym
      end

      def to_svg_attribute
        tmp = to_s
              .split('__')
              .then { |first, *rest| [first, rest.map(&:capitalize).join] }
              .join
        tmp.to_s.delete_prefix('@').gsub('_', '-')
      end
    end
  end
end

String.include Relax::String
Symbol.include Relax::SVG::Symbol
