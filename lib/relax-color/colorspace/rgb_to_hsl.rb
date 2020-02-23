module RgbToHsl

  def to_hsl
    [h,s,l].join(',')
  end

  def to_hsl_hash
    {h: h, s: s, l: l}
  end

  private

  def l
    (100*(_max + _min)/2).round
  end

  def s
    tmp_s = 1
    return 0 if _max == _min
    if l  < 50
      tmp_s = (_max - _min)/(_max + _min)
    elsif l > 50
      tmp_s = ( _max - _min)/(2.0 - _max - _min)
    end
    (100*tmp_s).round
  end

  def h
    return 0 if _max == _min
    case _rgb_max[:channel]
    when :r
      _h = (_g - _b)/(_max - _min)
    when :g
      _h = 2.0 + (_b - _r)/(_max - _min)
    when :b
      _h = 4.0 + (_r - _g)/(_max - _min)
    end
    _h = (_h * 60).round
    _h += 360 if _h < 0
    _h
  end

  def _r
    r/255.0
  end

  def _g
    g/255.0
  end

  def _b
    b/255.0
  end

  def _rgb
    {r: _r, g: _g, b: _b}
  end

  def _rgb_max
    [:channel, :value].zip(_rgb.max_by{|_,v| v}).to_h
  end

  def _rgb_min
    [:channel, :value].zip(_rgb.min_by{|_,v| v}).to_h
  end

  def _max
    _rgb_max[:value]
  end

  def _min
    _rgb_min[:value]
  end

end