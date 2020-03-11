# frozen_string_literal: true

module Relax
  # Patches for the standard String class
  module StringPatches
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
    module ArrayPatches
      def to_cmd_params
        if first.is_a? Array
          map { |e| e.join(',') }.join(' ')
        else
          join(' ')
        end
      end
    end
    # Patches for the standard Symbol class
    # used in module SVG
    module SymbolPatches
      def to_instance_var
        to_s.prepend('@').to_sym
      end

      # To-do: remove element_ prefix
      # required for element_class and element_id
      def to_svg_attribute
        tmp = to_s
              .split('__')
              .yield_self { |fst, *rst| [fst, rst.map(&:capitalize).join] }
              .join
        tmp.to_s.delete_prefix('@').delete_prefix('element_').gsub('_', '-')
      end
    end
  end
end

String.include Relax::StringPatches
Array.include Relax::SVG::ArrayPatches
Symbol.include Relax::SVG::SymbolPatches
