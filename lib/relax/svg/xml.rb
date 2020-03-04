# frozen_string_literal: true

module Relax
  module SVG
    # Implemented for indenting XML code
    # avoiding to use dependencies such nokogiri
    # Use:
    # Relax.SVG.XML.new(xml_code)
    #              .indent spaces: 4, version: 1.0
    # It returns an indented string
    class XML
      attr_reader :code

      def initialize(code)
        # To-do: implement a Relax:Error for this
        raise 'Must be a string' unless code.is_a? String

        # To-do: implement the validation
        # raise 'Not a valid XML code' unless valid_code

        @code = code
        @scan_lines = scan_lines
      end

      def to_xml
        indent
      end

      def indent(spaces: 2, xml_version: '1.0')
        step = 0
        mapping.map do |line, tag|
          step -= 1 if tag[1] == '/'
          tmp = ' ' * spaces * step + line
          step += 1 unless tag.include? '/'
          tmp
        end.unshift(xml_version(xml_version))
               .join("\n").strip
      end

      private

      def xml_version(version)
        case version
        when '1.0'
          '<?xml version="1.0"?>'
        end
      end

      def mapping
        @scan_lines.map do |line|
          line.split.then do |ary|
            closing = ary.first if ary.size == 1
            if ary.size > 1
              opening = ary.first
              closing = line[-2..-1].then { |c| c == '/>' ? c : c[-1] }
            end
            [line] << [opening || nil, closing].join
          end
        end
      end

      # To-do: strip \n and \r and spaces between tags
      # so it cna also be used with a non minified string as input
      def scan_lines
        @code.scan(/[^>]*>/)
      end
    end
  end
end
