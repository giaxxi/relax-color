# frozen_string_literal: true

require_relative '../lib/relax-color.rb'

# ADD TESTS FOR GRAYS AND COLORS
describe Relax::ColorSpace::Hsla do
  let(:my_color) { Relax::ColorSpace::Hsla.new(341, 100, 50) }

  it 'Instantiate a ColorSpace::Hsla object by default method' do
    expect(my_color).to be_a Relax::ColorSpace::Hsla
  end

  context 'Instance initialization errors' do
    it  'Raises ArgumentError when instantiating' \
        'an object with a wrong argument' do
      expect { Relax::ColorSpace::Hsla.new(10) }.to raise_error ArgumentError
    end
    it  'Raises ArgumentError when instantiating' \
        'an object with a wrong argument' do
      expect { Relax::ColorSpace::Hsla.new('a', 10, 10) }
        .to raise_error ArgumentError
    end
    it  'Raises ChannelsOutOfRange when instantiating' \
        'an object with a wrong argument' do
      expect { Relax::ColorSpace::Hsla.new(361, 0, 0) }
        .to raise_error Relax::Errors::Hsla::ChannelsOutOfRange
      expect { Relax::ColorSpace::Hsla.new(-1, 0, 0) }
        .to raise_error Relax::Errors::Hsla::ChannelsOutOfRange
      expect { Relax::ColorSpace::Hsla.new(1, 0, 101) }
        .to raise_error Relax::Errors::Hsla::ChannelsOutOfRange
    end
  end
end

describe Relax::ColorSpace::Hsla do
  let(:my_color) { Relax::ColorSpace::Hsla.new(341, 100, 50) }

  context Relax::HslToRgb do
    it 'Converts properly, hsl to rgba (1)' do
      expect(Relax::ColorSpace::Hsla.new(341, 100, 50, 0.2)
        .to_rgba).to eql [255, 0, 81, 0.2]
    end
    it 'Converts properly, hsl to rgba (2)' do
      expect(Relax::ColorSpace::Hsla.new(100, 100, 50, 0.1)
        .to_rgba).to eql [85, 255, 0, 0.1]
    end
  end
end

describe Relax::ColorSpace::Hsla do
  let(:my_color) { Relax::ColorSpace::Hsla.new(341, 100, 50, 0.5) }
  context 'Other methods' do
    it 'Can be converted to Relax::Color by calling to_relax_color' do
      expect(my_color.to_relax_color).to be_a Relax::Color
    end
    it 'Returns a String when called .to_s' do
      expect(my_color.to_s).to eq '341, 100, 50, 0.5'
    end
    it 'Returns an Array when called .to_a' do
      expect(my_color.to_a).to eq [341, 100, 50, 0.5]
    end
    it 'Returns a Hash when called .to_h' do
      expect(my_color.to_h)
        .to eq({ hue: 341, saturation: 100, lightness: 50, alpha: 0.5 })
    end
    it 'Returns a String when called .to_s' do
      expect(my_color.to_s).to eq '341, 100, 50, 0.5'
    end
    it 'Raises NotImplemented string when called .to_hex' do
      expect { my_color.to_hex }
        .to raise_error Relax::Errors::Hsla::NotImplemented
    end
  end
end
