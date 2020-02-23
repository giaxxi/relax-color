class ColorSpace::Hsl
  include HslToRgb

  MIN = 0
  H_MAX = 360
  S_MAX = 100
  L_MAX = 100

  attr_reader :h, :s, :l

  def initialize(h,s,l) # it expects a string as argument
    @h = Integer(h)
    @s = Integer(s)
    @l = Integer(l)
    raise Relax::Errors::MalformedHsl::ChannelsOutOfRange unless self.valid?
  end

  def to_hex
    raise 'Not implemented'
  end

  def hsl
    [h,s,l].join(',')
  end

  def to_relative
    [@h / 360.0, @s / 100.0, @l / 100.0].map { |e| e.round(5)}.join(',')
  end

  def to_relax_color
    Relax::Color.hsl(h,s,l)
  end

  protected

  def valid?
    h_valid? && s_valid? &&  l_valid?
  end

  def h_valid?
    (MIN..H_MAX).include? h
  end

  def s_valid?
    (MIN..S_MAX).include? s
  end

  def l_valid?
    (MIN..L_MAX).include? l
  end

end
