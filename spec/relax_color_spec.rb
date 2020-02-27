# frozen_string_literal: true

require_relative '../lib/relax_color.rb'

describe Relax::Color do
  let(:my_color) { Relax::Color.new(:rgba, r: 1, g: 1, b: 1, a: 0.8) }

  it 'Raises an error if there is a wrong colorspace type' do
    expect { Relax::Color.new(:rgb, r: 1, g: 1, b: 1, a: 0.8) }
      .to raise_error 'Not a valid color encoding'
  end

  it 'Instantiate a RGBA color by default method new' do
    expect(my_color).to be_a Relax::Color
  end
  it 'Instantiate a RGBA color by calling the module RGBA' do
    my_color = Relax::Color::RGBA.new(1, 1, 1, 0.8)
    expect(my_color).to be_a Relax::Color
  end
  it 'Instantiate a RGBA color ba calling the class method .rgba' do
    my_color = Relax::Color.rgba(1, 1, 1, 0.8)
    expect(my_color).to be_a Relax::Color
  end

  it 'Relax::Color :rgba instance responds to colorspace' \
     'and returns an instance of ColorSpace::Rgba' do
    expect(my_color).to respond_to(:colorspace)
    expect(my_color.colorspace).to be_a ColorSpace::Rgba
  end

  it 'Responds to to_hsl and returning an instance of ColorSpace::Hsl' do
    expect(my_color).to respond_to(:to_hsl)
    expect(my_color.to_hsl).to be_a Relax::Color
  end
end
