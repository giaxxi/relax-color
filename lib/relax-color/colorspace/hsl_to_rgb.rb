module HslToRgb
  RGB_MAX = 255
  RGB_MIN = 0

  attr_reader :piero

  def to_rgba
    [r, g, b, 1.0].join(',')
  end

  def to_rgba_hash
    {r: r, g: g, b: b, a: 1.0}
  end

  protected

  def _h
    h.fdiv 360
  end

  def _s
    s.fdiv 100
  end

  def _l
    l.fdiv 100
  end

  def gray_level
    (RGB_MAX * _l).round
  end

  def tmp_1
    if _l < 0.5
      _l * (1.0 + _s)
    else
      _l + _s - _l * _s
    end
  end

  def tmp_2
    2 * _l - tmp_1
  end

  def tmp_r
    _h + 0.333
  end

  def tmp_g
    _h
  end

  def tmp_b
    tmp = _h - 0.333
    tmp += 1.0 if tmp < 0
    tmp
  end

  def r
    return gray_level if s == 0
    (channel(tmp_r) * 255).round
  end

  def g
    return gray_level if s == 0
    (channel(tmp_g) * 255).round
  end

  def b
    return gray_level if s == 0
    (channel(tmp_b) * 255).round
  end

  def channel(tmp_ch)
    return gray_level if s == 0
    if tmp_ch * 6 < 1
      tmp_2 + (tmp_1 - tmp_2) * 6 * tmp_ch
    elsif tmp_ch * 2 < 1
      tmp_1
    elsif tmp_ch * 3 < 2
      tmp_2 + (tmp_1 - tmp_2) * (0.666 - tmp_ch) * 6
    else
      tmp_2
    end
  end

end

# class Hsl
#   include HslToRgb
#   attr_reader :h, :s, :l
#   def initialize(h, s, l)
#     @h, @s, @l = h, s, l
#   end
# end