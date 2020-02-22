module ValidateColorspaceString

  private

    def valid_rgba_format?(colorspace_string)
      raise Relax::Errors::MalformedRgba::ArgumentMustBeAString unless valid_string?(colorspace_string)
      raise Relax::Errors::MalformedRgba::ChannelsMustBeNumeric unless all_numeric?(colorspace_string)
      raise Relax::Errors::MalformedRgba::MissingOrExceedingChannels unless all_rgba_channels?(colorspace_string)
    end

    def valid_string?(colorspace_string)
      colorspace_string.is_a? String
    end

    def all_numeric?(colorspace_string)
      colorspace_string.split(',').all?(&:is_numeric?)
    end

    def all_rgba_channels?(colorspace_string)
      [3, 4].include? colorspace_string.split(',').size
    end

end