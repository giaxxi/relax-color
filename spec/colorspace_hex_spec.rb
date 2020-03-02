# frozen_string_literal: true

require_relative '../lib/relax-color.rb'

describe Relax::ColorSpace::Hex do
  let(:my_color) { Relax::ColorSpace::Hex.new('ff0050') }

  it 'Instantiate a ColorSpace::Hex object by default method' do
    expect(my_color).to be_a Relax::ColorSpace::Hex
  end

  context 'Instance initialization errors' do
    it  'Raises StringMustBeSixChars when' \
        'instantiating an object with a wrong argument' do
      expect { Relax::ColorSpace::Hex.new('1234567') }
        .to raise_error Relax::Errors::Hex::StringMustBeSixChars
      expect { Relax::ColorSpace::Hex.new('12345') }
        .to raise_error Relax::Errors::Hex::StringMustBeSixChars
    end
  end
end

describe Relax::ColorSpace::Hex do
  let(:my_color) { Relax::ColorSpace::Hex.new('ff0050') }

  context 'Conversion to RGBA' do
    it 'Returns a rgba colorspace coded array' do
      expect(my_color.to_rgba).to be_a Array
    end
    it  'Returns a rgba colorspace coded array' \
        'having the alpha channel set to 1.0' do
      expect(my_color.to_rgba.size).to eq 4
      expect(my_color.to_rgba.last).to eq 1.0
    end
    it  'Returns a Hash useful to instantiate a' \
        'ColorSpace::Rgba object when calling .to_rgba_hash' do
      rgba_hash = my_color.to_rgba_hash
      expect(rgba_hash)
        .to eq({ red: 255, green: 0, blue: 80, alpha: 1.0 })
      rgba = Relax::ColorSpace::Rgba.new(*rgba_hash.values)
      expect(rgba).to be_a Relax::ColorSpace::Rgba
    end
  end

  context 'Conversion to HSL' do
    it 'Raises a not implemented error' do
      expect { my_color.to_hsl }
        .to raise_error Relax::Errors::Hex::NotImplemented
    end
  end
end

describe Relax::ColorSpace::Hex do
  let(:my_color) { Relax::ColorSpace::Hex.new('ff0050') }

  context 'Other methods' do
    it 'Responds to .to_a' do
      expect(my_color.to_a).to be_a Array
    end
    it 'Respont .to_s' do
      expect(my_color.to_s).to eq 'ff0050'
    end
    it 'Respont .to_h' do
      expect(my_color.to_h)
        .to eq({ red: 'ff', green: '00', blue: '50' })
    end
    it 'Responds to .to_html' do
      expect(my_color.to_html).to eq '#ff0050'
    end
  end

  it 'Raises error calling protected methods' do
    expect { my_color.valid? }.to raise_error NoMethodError
    expect { my_color.valid_chars? }.to raise_error NoMethodError
  end
end
