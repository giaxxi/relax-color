class HexColor

  attr_reader :hex

  def initialize(hex)
    @hex = hex.to_s.delete_prefix('#')
    valid?
  end

  def valid?
    error_message = "Malformed hex color code, should be '#000000' up to '#ffffff'"
    raise error_message if @hex.start_with? '#'
    raise error_message if hex.size != 6
    raise error_message unless hex.chars.all?{ |ch| [*'0'..'9', *'a'..'f' ].include?(ch) }
    true
  end

  def to_html
    ['#', hex].join
  end

  def to_rgba
    rgb = hex.chars.each_slice(2).map{ |ee| ee.unshift('0x').join.to_i(16) }.join(',')
  end

end

# hex = HexColor.new('z99999')
# p hex
# p hex.valid?
# p hex.to_html
# p hex.to_rgba
# RgbaColor
