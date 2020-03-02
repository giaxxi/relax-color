# frozen_string_literal: true

require_relative '../lib/relax.rb'

describe Relax::ColorSpace::Rgba do
  let(:my_color) { Relax::ColorSpace::Rgba.new(1, 1, 1, 0.8) }

  context 'Correct instantiating' do
    it 'Instantiate a Relax::ColorSpace::Rgba object by default method' do
      expect(my_color).to be_a Relax::ColorSpace::Rgba
    end

    it  'Instantiate a Relax::ColorSpace::Rgba object with alpha=1.0' \
        'if alpha channel is not specified' do
      my_color_no_alpha = Relax::ColorSpace::Rgba.new(1, 1, 1)
      expect(my_color_no_alpha).to be_a Relax::ColorSpace::Rgba
      expect(my_color_no_alpha.a).to equal 1.0
    end
  end
end

describe Relax::ColorSpace::Rgba do
  # let(:my_color) {Relax::ColorSpace::Rgba.new(1, 1, 1, 0.8)}
  context 'Instance initialization errors' do
    it  'Raises ArgumentError when instantiating' \
        'an object with a wrong argument' do
      expect { Relax::ColorSpace::Rgba.new(10) }.to raise_error ArgumentError
    end
    it  'Raises ArgumentError when instantiating' \
        'an object with a wrong argument' do
      expect { Relax::ColorSpace::Rgba.new('a', 10, 10, 1) }
        .to raise_error ArgumentError
    end
    it  'Raises ChannelsOutOfRange when instantiating' \
        'an object with a wrong argument' do
      expect { Relax::ColorSpace::Rgba.new(256, 0, 0, 0) }
        .to raise_error Relax::Errors::Rgba::ChannelsOutOfRange
      expect { Relax::ColorSpace::Rgba.new(-1, 0, 0, 0) }
        .to raise_error Relax::Errors::Rgba::ChannelsOutOfRange
      expect { Relax::ColorSpace::Rgba.new(1, 0, 0, 1.1) }
        .to raise_error Relax::Errors::Rgba::ChannelsOutOfRange
    end
  end
end

describe Relax::ColorSpace::Rgba do
  let(:my_color) { Relax::ColorSpace::Rgba.new(1, 1, 1, 0.8) }

  context 'Conversion to HEX' do
    it 'Returns a hex colorspace coded string' do
      expect(my_color.to_hex).to be_a String
    end
    it  'Returns a String which can be used to ' \
        'instantiate a ColorSpace::Hex object' do
      colorspace_hex = Relax::ColorSpace::Hex.new(my_color.to_hex)
      expect(colorspace_hex).to be_a Relax::ColorSpace::Hex
    end
    it 'Returns the hex colorspace string when called .to_hex' do
      expect(my_color.to_hex).to be_a String
      expect(my_color.to_hex).to eq '010101'
    end
  end
end

describe Relax::ColorSpace::Rgba do
  let(:my_color) { Relax::ColorSpace::Rgba.new(1, 1, 1, 0.8) }
  context 'Conversion to HSL' do
    it 'It returns an Array with correct conversion' do
      rgb_color = Relax::ColorSpace::Rgba.new(250, 28, 129, 0.3)
      expect(rgb_color.to_hsla).to eq [333, 96, 55, 0.3]
    end
    it 'It returns an Hash with correct conversion' do
      rgb_color = Relax::ColorSpace::Rgba.new(250, 28, 129, 0.55)
      expect(rgb_color.to_hsla_hash)
        .to eq({ hue: 333, saturation: 96, lightness: 55, alpha: 0.55 })
    end
    it  'Returns a Hash which can be used' \
        'to instantiate a ColorSpace::Hsl object' do
      hsla_hash = my_color.to_hsla_hash
      hsl_colorspace = Relax::ColorSpace::Hsla.new(hsla_hash[:hue],
                                                   hsla_hash[:saturation],
                                                   hsla_hash[:lightness],
                                                   hsla_hash[:alpha])
      expect(hsl_colorspace).to be_a Relax::ColorSpace::Hsla
    end
  end
end

describe Relax::ColorSpace::Rgba do
  let(:my_color) { Relax::ColorSpace::Rgba.new(1, 1, 1, 0.8) }

  context 'Other methods' do
    it  'Can be converted to Relax::Color' \
        'by calling to_relax_color' do
      expect(my_color.to_relax_color).to be_a Relax::Color
    end
    it 'Returns an array when called .to_a' do
      expect(my_color.to_a).to eq [1, 1, 1, 0.8]
    end
    it 'Returns an hash when called .to_h' do
      expect(my_color.to_h)
        .to eq({ red: 1, green: 1, blue: 1, alpha: 0.8 })
    end
    it  'Returns the hex colorspace string' \
        'starting with # when called .to_html_hex' do
      html_hex = my_color.to_html_hex
      expect(html_hex).to be_a String
      expect(html_hex[1..-1]).to eq '010101'
      expect(html_hex[0]).to eq '#'
    end
  end
end

describe Relax::ColorSpace::Rgba do
  let(:my_color) { Relax::ColorSpace::Rgba.new(1, 1, 1, 0.8) }

  context 'Transparency, opacity, light?, dark?' do
    it 'Respond to .transparent? returning true or false' do
      expect(my_color.transparent?).to be true
      expect(my_color.transparent?).to be true
    end

    it 'Returns true or false when a color is dark' do
      dark_color = Relax::ColorSpace::Rgba.new(115, 151, 101)
      expect(dark_color.dark?).to be true
      expect(dark_color.light?).to be false
    end

    it 'Returns true or false when a color is light' do
      light_color = Relax::ColorSpace::Rgba.new(122, 155, 105)
      expect(light_color.dark?).to be false
      expect(light_color.light?).to be true
    end
  end
end

describe Relax::ColorSpace::Rgba do
  let(:my_color) { Relax::ColorSpace::Rgba.new(1, 1, 1, 0.8) }

  context 'Opacity' do
    it 'Sets alpha to 1.0 calling .opaque!, returning true if done' do
      my_transparent_color = Relax::ColorSpace::Rgba.new(1, 1, 1, 0.8)
      expect(my_transparent_color.opaque!).to be true
      expect(my_transparent_color.a).to eq 1.0
    end

    it 'Sets alpha to 1 calling .opaque!, returns false when already opaque' do
      my_opaque_color = Relax::ColorSpace::Rgba.new(1, 1, 1)
      expect(my_opaque_color.opaque!).to be false
      expect(my_opaque_color.a).to eq 1.0
    end

    it  'Returns a new Object with alpha channel set to 1.0' \
        'calling .opaque if the object is transparent' do
      my_transparent_color = Relax::ColorSpace::Rgba.new(1, 1, 1, 0.8)
      my_opaque_color = Relax::ColorSpace::Rgba.new(1, 1, 1)
      expect(my_opaque_color).not_to equal my_transparent_color
      expect(my_opaque_color.a).to eq 1.0
    end

    it 'Returns the same Object calling .opaque if it is already opaque' do
      my_opaque_color = Relax::ColorSpace::Rgba.new(1, 1, 1)
      expect(my_opaque_color.opaque).to equal my_opaque_color
      expect(my_opaque_color.a).to eq 1.0
    end
  end
end
