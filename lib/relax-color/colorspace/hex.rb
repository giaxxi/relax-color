class ColorSpace::Hex

  attr_reader :hex

  def initialize(hex)
    @hex = hex.to_s.delete_prefix('#')
    valid?
  end

  def valid?
    raise Relax::Errors::MalformedHex::HashAtBeginingIsNotRequired if @hex.start_with? '#'
    raise Relax::Errors::MalformedHex::HexStringMustBeSixChars if hex.size != 6
    raise Relax::Errors::MalformedHex::HexStringBadChars unless hex.chars.all?{ |ch| [*'0'..'9', *'a'..'f' ].include?(ch) }
    true
  end

  def to_html_hex
    hex.prepend '#'
  end

  def to_rgba
    rgb = hex.chars.each_slice(2).map{ |ee| ee.unshift('0x').join.to_i(16) } << 1.0
  end

  def to_rgba_hash
    [:r, :g, :b, :a].zip(to_rgba).to_h
  end

end