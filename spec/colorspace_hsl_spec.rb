# frozen_string_literal: true

require_relative '../lib/relax_color.rb'

# ADD TESTS FOR GRAYS AND COLORS
describe ColorSpace::Hsl do
  let(:my_color) { ColorSpace::Hsl.new(341, 100, 50) }

  it 'Instantiate a ColorSpace::Hsl object by default method' do
    expect(my_color).to be_a ColorSpace::Hsl
  end

  context 'Instance initialization errors' do
    it  'Raises ArgumentError when instantiating' \
        'an object with a wrong argument' do
      expect { ColorSpace::Hsl.new(10) }.to raise_error ArgumentError
    end
    it  'Raises ArgumentError when instantiating' \
        'an object with a wrong argument' do
      expect { ColorSpace::Hsl.new('a', 10, 10) }.to raise_error ArgumentError
    end
    it  'Raises ChannelsOutOfRange when instantiating' \
        'an object with a wrong argument' do
      expect { ColorSpace::Hsl.new(361, 0, 0) }
        .to raise_error Relax::Errors::Hsl::ChannelsOutOfRange
      expect { ColorSpace::Hsl.new(-1, 0, 0) }
        .to raise_error Relax::Errors::Hsl::ChannelsOutOfRange
      expect { ColorSpace::Hsl.new(1, 0, 101) }
        .to raise_error Relax::Errors::Hsl::ChannelsOutOfRange
    end
  end
end

describe ColorSpace::Hsl do
  let(:my_color) { ColorSpace::Hsl.new(341, 100, 50) }

  context HslToRgb do
    it 'Converts properly, hsl to rgba (1)' do
      expect(ColorSpace::Hsl.new(341, 100, 50).to_rgba).to eql [255, 0, 81, 1.0]
    end
    it 'Converts properly, hsl to rgba (2)' do
      expect(ColorSpace::Hsl.new(100, 100, 50).to_rgba).to eql [85, 255, 0, 1.0]
    end
  end
end

describe ColorSpace::Hsl do
  let(:my_color) { ColorSpace::Hsl.new(341, 100, 50) }
  context 'Other methods' do
    it 'Can be converted to Relax::Color by calling to_relax_color' do
      expect(my_color.to_relax_color).to be_a Relax::Color
    end
    it 'Returns a String when called .to_s' do
      expect(my_color.to_s).to eq '341, 100, 50'
    end
    it 'Returns an Array when called .to_a' do
      expect(my_color.to_a).to eq [341, 100, 50]
    end
    it 'Returns a Hash when called .to_h' do
      expect(my_color.to_h).to eq({ h: 341, s: 100, l: 50 })
    end
    it 'Returns a String when called .to_s' do
      expect(my_color.to_s).to eq '341, 100, 50'
    end
    it 'Raises NotImplemented string when called .to_hex' do
      expect { my_color.to_hex }
        .to raise_error Relax::Errors::Hsl::NotImplemented
    end
  end
end
