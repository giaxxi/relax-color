# frozen_string_literal: true

# Conversion from RGBA colorspace to HSL
module RgbToHsl
  def to_hsl
    calculate_channels
    [@hue, @saturation, @lightness]
  end

  def to_hsl_hash
    %i[h s l].zip(to_hsl).to_h
  end

  def lightness
    to_hsl.last
  end

  private

  def init
    @r_rel, @g_rel, @b_rel = to_relative
    @max = to_relative.max
    @min = to_relative.min
    @delta = @max - @min
    @sum = @max + @min
    @lightness = (calculate_lightness * 100).round
  end

  def calculate_channels
    init
    @hue = calculate_hue.round
    @saturation = (calculate_saturation * 100).round
  end

  def calculate_hue
    return 0 if @min == @max

    if @r_rel == @max
      ((60 * (@g_rel - @b_rel) / @delta) + 360) % 360
    elsif @g_rel == @max
      (60 * (@b_rel - @r_rel) / @delta) + 120
    else
      (60 * (@r_rel - @g_rel) / @delta) + 240
    end
  end

  def calculate_lightness
    0.5 * @sum
  end

  def calculate_saturation
    return 0 if @min == @max

    if @lightness == 100
      1.0
    elsif @lightness <= 50
      @delta / @sum
    else
      @delta / (2 - @sum)
    end
  end
end
