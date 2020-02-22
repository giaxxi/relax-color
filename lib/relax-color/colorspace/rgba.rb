class ColorSpace::Rgba
  include RgbToHsl
  include ValidateColorspaceString

  MAX = 255
  MIN = 0

  attr_reader :r, :g, :b, :a

  def initialize(rgba) # it expects a string as argument
    valid_rgba_format?(rgba)
    r, g, b, a = rgba.split(',')
    @r = Integer(r)
    @g = Integer(g)
    @b = Integer(b)
    @a = (Float(a) if a) || 1.0
    raise Relax::Errors::MalformedRgba::ChannelsOutOfRange unless valid_range?
  end

  def to_a
    [r,g,b,a] 
  end

  def to_html
    rgba = to_a.join(',')
    ['rgba(', rgba, ')'].join
  end

  def opaque!
    if a < 1
      @a = 1.0
      return true
    end
    false
  end

  def opaque
    return ColorSpace::Rgba.new([r,g,b].join(',')) if a < 1
    self
  end

  def transparent?
    a < 1
  end

  def dark?
    [r,g,b].any?{ |ch| ch < 128 }
  end

  def to_relative
    hex = [r,g,b].map{ |e| (e.fdiv(MAX)).round(5) }.join(',')
  end

  def to_hex
    hex = [r,g,b].map{ |e| e.to_i.to_s(16).rjust(2, '0') }.join
  end

  def to_relax_color
    Relax::Color.rgba(r,g,b,a)
  end

  private

    def valid_range?
      [r,g,b].none? { |ch| ch < MIN || ch > MAX} && (0.0..1.0).include?(a)
    end

end