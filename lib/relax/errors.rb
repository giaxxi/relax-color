# frozen_string_literal: true

module Relax
  module Errors
    module Color
      class NotImplemented < StandardError; end
      class InvalidColorspace < StandardError; end
    end

    module Hsla
      class NotImplemented < StandardError; end
      class ChannelsOutOfRange < StandardError; end
    end

    module Rgba
      class ChannelsOutOfRange < StandardError; end
      class ChannelsMustBeNumeric < StandardError; end
      class MissingOrExceedingChannels < StandardError; end
    end
    # class MalformedHex < StandardError; end
    module Hex
      class NotImplemented < StandardError; end
      class StringMustBeSixChars < StandardError; end
      class InvalidChars < StandardError; end
    end

    module SVG
      class MustBeAnArray < StandardError; end
    end
  end
end
