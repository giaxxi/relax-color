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
        CURVES = {
          cubic: { abs: 'C', rel: 'c', ctrl_pts: 2 },
          cubic_smooth: { abs: 'S', rel: 's', ctrl_pts: 1 },
          quadratic: { abs: 'Q', rel: 'q', ctrl_pts: 2 },
          quadratic_smooth: { abs: 'T', rel: 't', ctrl_pts: 1 }
        }.freeze

        def initialize
          @data = []
          yield self if block_given?
        end

        def data
          @data.join.strip
        end

        def move_to(args)
          type, point = args.first
          params = validate_point(point).join(',')
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
            params = validate_point(point).join(',')
            cmd = command params, type, rel: 'l', abs: 'L'
            add_command cmd
          end
        end

        def curve_to(args)
          assign_ref_and_type(args)
          point = validate_point(args[@ref])
          ctrl_pts = validate_points(args[@type], CURVES[@type][:ctrl_pts])
          params = [ctrl_pts, point].flatten.each_slice(2).to_a.to_cmd_params
          add_command command(params, @ref, CURVES[@type])
        end

        private

        def add_command(command)
          @data << command
          self
        end

        def command(params, ref, cmd)
          if RELATIVE.include? ref
            "#{cmd[:rel]}#{params} "
          elsif ABSOLUTE.include? ref
            "#{cmd[:abs]}#{params} "
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

        def assign_ref_and_type(args)
          @ref = pick_the_key(valid_refs.select { |k| args[k] })
          @type = pick_the_key(CURVES.keys.select { |k| args[k] })
        end

        def pick_the_key(ary)
          raise UnknownPathCommand unless ary.size == 1

          ary.first
        end

        def valid_keys
          CURVES.keys + valid_references
        end

        def valid_refs
          ABSOLUTE + RELATIVE
        end
      end
    end
  end
end
