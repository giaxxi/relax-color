module Relax::Errors
  class MalformedColor < StandardError; end
  class MalformedRgba < MalformedColor; end
  # class MalformedHex < MalformedColor; end
  module MalformedHex
    class HexStringMustBeSixChars < MalformedColor; end
    class HashAtBeginingIsNotRequired < MalformedColor; end
    class HexStringBadChars < MalformedColor; end
  end
end
