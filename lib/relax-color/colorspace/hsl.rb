class ColorSpace::Hsl

  MIN = 0
  H_MAX = 360
  S_MAX = 100
  L_MAX = 100

  attr_reader :h, :s, :l

  def initialize(hsl)
    h,s,l = hsl.split(',')
    @h = Integer(h)
    @s = Integer(s)
    @l = Integer(l)
    raise 'Malformed HSL color' unless self.valid?
  end

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


  def to_color
    Color::HSL.new(h,s,l)
  end

end
