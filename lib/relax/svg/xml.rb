# frozen_string_literal: true

# To-do: maybe switch to https://github.com/xml4r/libxml-ruby
require 'rexml/document'

module Relax
  module SVG
    # Implemented for indenting XML code
    # avoiding to use dependencies such nokogiri
    # Use:
    # Relax.SVG.XML.new(xml_code)
    #              .indent spaces: 4, version: 1.0
    # It returns an indented string
    class XML
      attr_reader :code, :xml

      def initialize(code)
        # To-do: implement a Relax:Error for this
        raise 'Must be a string' unless code.is_a? String

        # To-do: implement the validation
        # raise 'Not a valid XML code' unless valid_code
        @code = code.prepend xml_version
        @xml = String.new
        to_xml
      end

      # To-do: maybe implement this method
      def write_to_file(); end

      private

      def to_xml(spaces: 2)
        document = REXML::Document.new @code
        document.write indent: spaces, output: @xml
      end

      def xml_version(version = '1.0')
        case version
        when '1.0'
          '<?xml version="1.0"?>'
        end
      end
    end
  end
end
