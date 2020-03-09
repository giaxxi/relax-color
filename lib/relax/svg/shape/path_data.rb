# frozen_string_literal: true

module Relax
  module SVG
    module Shape
      # https://www.w3.org/TR/SVG2/paths.html#TheDProperty
      class PathData
        include Relax::Validator::SVG
        UnknownPathCommand = Relax::Errors::SVG::UnknownPathCommand
        VERTICAL = %i[v ver vertical].freeze
        HORIZONTAL = %i[h hor horizontal].freeze
        RELATIVE = %i[rel relative].freeze
        ABSOLUTE = %i[abs absolute].freeze

        def initialize
          @data = []
          yield self if block_given?
        end

        def data
          @data.join.strip
        end

        def move_to(args)
          type, point = args.first
          validate_point(point)
          params = point.join(',')
          cmd = command params, type, rel: 'm', abs: 'M'
          add_command cmd
        end

        def close_path
          add_command 'Z'
        end

        def line_to(args)
          type, point = args.first
          if (VERTICAL + HORIZONTAL).include? point.last
            horizontal_or_vertical_line(type, point)
          else
            validate_point(point)
            params = point.join(',')
            cmd = command params, type, rel: 'l', abs: 'L'
            add_command cmd
          end
        end

        def curve_to(args)
          type, point = args.first
          coords = args[:controls] << point
          if RELATIVE.include? type
            do_curve_to(coords, 'c')
          elsif ABSOLUTE.include? type
            do_curve_to(coords, 'C')
          else raise UnknownPathCommand
          end
        end

        private

        def add_command(command)
          @data << command
          self
        end

        def command(params, type, args)
          if RELATIVE.include? type
            "#{args[:rel]}#{params} "
          elsif ABSOLUTE.include? type
            "#{args[:abs]}#{params} "
          else
            raise UnknownPathCommand
          end
        end

        def horizontal_or_vertical_line(type, point)
          value, direction = point
          if HORIZONTAL.include? direction
            add_command command(value, type, rel: 'h', abs: 'H')
          elsif VERTICAL.include? direction
            add_command command(value, type, rel: 'v', abs: 'V')
          else
            raise UnknownPathCommand
          end
        end

        def do_curve_to(coords, type)
          coords.each { |point| validate_point(point) }
          coords = coords.map { |point| point.join(',') }.join(' ')
          add_command("#{type}#{coords} ")
        end
      end
    end
  end
end
