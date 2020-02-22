module Relax::Errors
  class MalformedColor < StandardError; end

  module MalformedRgba
    class ArgumentMustBeAString < MalformedColor; end
    class ChannelsOutOfRange < MalformedColor; end
    class ChannelsMustBeNumeric < MalformedColor; end
    class MissingOrExceedingChannels < MalformedColor; end
  end
  # class MalformedHex < MalformedColor; end
  module MalformedHex
    class HexStringMustBeSixChars < MalformedColor; end
    class HashAtBeginingIsNotRequired < MalformedColor; end
    class HexStringBadChars < MalformedColor; end
  end
end
