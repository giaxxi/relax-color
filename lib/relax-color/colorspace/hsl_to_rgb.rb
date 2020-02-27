# frozen_string_literal: true

# Conversion from HSL colorspace to RGBA
module HslToRgb
  H_MAX = 360
  S_MAX = 100
  L_MAX = 100
  RGB_MAX = 255
  ONE_HALF = 1.0 / 2.0
  ONE_THIRD = 1.0 / 3.0
  ONE_SIXTH = 1.0 / 6.0
  TWO_THIRD = 2.0 / 3.0

  def to_rgba_hash
    init
    rgba_hash = %i[r g b a].zip([red, green, blue, 1.0]).to_h
    %i[@h_rel @s_rel @l_rel @ttq @ttp @achromatic]
      .each { |var| remove_instance_variable var }
    rgba_hash
  end

  def to_rgba
    to_rgba_hash.values
  end

  private

  def init
    @h_rel = hue.fdiv H_MAX
    @s_rel = saturation.fdiv S_MAX
    @l_rel = lightness.fdiv L_MAX
    @ttq = init_ttq
    @ttp = 2 * @l_rel - @ttq
    @achromatic = (@l_rel * RGB_MAX).round
  end

  def init_ttq
    return @l_rel * (1 + @s_rel) if @l_rel < 0.5

    @l_rel + @s_rel - @l_rel * @s_rel
  end

  def hsv_channel_to_rgb(ttp, ttq, ttu)
    ttu += 1 if ttu.negative?
    ttu -= 1 if ttu > 1
    return ttp + (ttq - ttp) * 6 * ttu if ttu < ONE_SIXTH
    return ttq if ttu < ONE_HALF
    return ttp + (ttq - ttp) * (TWO_THIRD - ttu) * 6 if ttu < TWO_THIRD

    ttp
  end

  def red
    return @achromatic if saturation.zero?

    r = hsv_channel_to_rgb(@ttp, @ttq, @h_rel + ONE_THIRD)
    (r * RGB_MAX).round
  end

  def green
    return @achromatic if saturation.zero?

    g = hsv_channel_to_rgb(@ttp, @ttq, @h_rel)
    (g * RGB_MAX).round
  end

  def blue
    return @achromatic if saturation.zero?

    b = hsv_channel_to_rgb(@ttp, @ttq, @h_rel - ONE_THIRD)
    (b * RGB_MAX).round
  end
end
