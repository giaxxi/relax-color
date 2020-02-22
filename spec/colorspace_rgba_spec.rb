require_relative '../lib/relax-color.rb'

describe ColorSpace::Rgba do

  let(:my_color) {ColorSpace::Rgba.new('1,1,1,0.8')}

  it 'Instantiate a ColorSpace::Rgba object when argument is a String' do
    expect(my_color).to be_a ColorSpace::Rgba
  end

  it 'Instantiate a ColorSpace::Rgba object when argument contains spaces' do
    my_color_with_spaces = ColorSpace::Rgba.new('1,  1, 1, 0.8')
    expect(my_color_with_spaces).to be_a ColorSpace::Rgba
  end

  it 'Instantiate a ColorSpace::Rgba object with alpha=0.1 if alpha channel is not specified' do
    my_color_no_alpha = ColorSpace::Rgba.new('1,1,1')
    expect(my_color_no_alpha).to be_a ColorSpace::Rgba
    expect(my_color_no_alpha.a).to equal 1.0
  end

  context 'Calling to_hex on the ColorSpace::Rgba object' do
    it 'Returns a hex colorspace coded string' do
      expect(my_color.to_hex).to be_a String
    end
    it 'Returns a String which can be used to instantiate a ColorSpace::Hex object' do
      colorspace_hex = ColorSpace::Hex.new(my_color.to_hex)
      expect(colorspace_hex).to be_a ColorSpace::Hex
    end
  end

  context 'Calling to_hsl on the ColorSpace::Rgba object' do
    it 'Returns a hsl colorspace coded string' do
      expect(my_color.to_hex).to be_a String
    end
    it 'Returns a String which can be used to instantiate a ColorSpace::Hsl object' do
      colorspace_hsl = ColorSpace::Hsl.new(my_color.to_hsl)
      expect(colorspace_hsl).to be_a ColorSpace::Hsl
    end
  end

  context Relax::Errors do
    it 'Raises ArgumentMustBeAString when instantiating an object with a wrong argument' do
      expect{ ColorSpace::Rgba.new(100000) }.to raise_error Relax::Errors::MalformedRgba::ArgumentMustBeAString
    end
    it 'Raises ChannelsMustBeNumeric when instantiating an object with a wrong argument' do
      expect{ ColorSpace::Rgba.new('12,  12<,') }.to raise_error Relax::Errors::MalformedRgba::ChannelsMustBeNumeric
    end
    it 'Raises MissingOrExceedingChannels when..' do
      expect{ ColorSpace::Rgba.new('12') }.to raise_error Relax::Errors::MalformedRgba::MissingOrExceedingChannels
      expect{ ColorSpace::Rgba.new('12,1,1,1,1') }.to raise_error Relax::Errors::MalformedRgba::MissingOrExceedingChannels
    end
    it 'Raises ChannelsOutOfRange when instantiating an object with a wrong argument' do
      expect{ ColorSpace::Rgba.new('256,0,0,0') }.to raise_error Relax::Errors::MalformedRgba::ChannelsOutOfRange
      expect{ ColorSpace::Rgba.new('-1,0,0,0') }.to raise_error Relax::Errors::MalformedRgba::ChannelsOutOfRange
      expect{ ColorSpace::Rgba.new('1,0,0,1.1') }.to raise_error Relax::Errors::MalformedRgba::ChannelsOutOfRange
    end
  end

  context 'Conversions' do
    it 'Can be converted to Relax::Color by calling to_relax_color' do
      expect(my_color.to_relax_color).to be_a Relax::Color
    end

    it 'Returns an array when called .to_a' do
      expect(my_color.to_a).to eq [1, 1, 1, 0.8]
    end

    it 'Returns the hex colorspace string when callee .to_hex' do
      expect(my_color.to_hex).to be_a String
      expect(my_color.to_hex).to eq "010101"
    end

    it 'Includes RgbToHsl module, so .to_hsl method is available, it returns an hsl string' do
      rgb_color = ColorSpace::Rgba.new('250,28,129')
      expect(rgb_color.to_hsl).to be_a String
      expect(rgb_color.to_hsl).to eq "333,96,55"
    end

  end

  context 'Transparency and opacity' do
    it 'Respond to .transparent? returning true or false' do
      expect(my_color.transparent?).to be true
      expect(my_color.transparent?).to be true
    end

    it 'Sets alpha to 1.0 calling .opaque!, returning true if done.' do
      my_transparent_color = ColorSpace::Rgba.new('1,1,1,0.8')
      expect(my_transparent_color.opaque!).to be true
      expect(my_transparent_color.a).to eq 1.0
    end

    it 'Sets alpha to 1.0 calling .opaque!, returning false if it was already opaque.' do
      my_opaque_color = ColorSpace::Rgba.new('1,1,1')
      expect(my_opaque_color.opaque!).to be false
      expect(my_opaque_color.a).to eq 1.0
    end

    it 'Returns a new Object with alpha channel set to 1.0 calling .opaque if the object is transparent' do
      my_transparent_color = ColorSpace::Rgba.new('1,1,1,0.8')
      my_opaque_color = ColorSpace::Rgba.new('1,1,1')
      expect(my_opaque_color).not_to equal my_transparent_color
      expect(my_opaque_color.a).to eq 1.0
    end

    it 'Returns the same Object calling .opaque if it is already opaque.' do
      my_opaque_color = ColorSpace::Rgba.new('1,1,1')
      expect(my_opaque_color.opaque).to equal my_opaque_color
      expect(my_opaque_color.a).to eq 1.0
    end

  end

end
