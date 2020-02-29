# frozen_string_literal: true

require_relative '../lib/relax.rb'

describe Relax::Color do
  let(:my_color) { Relax::Color.new(:rgba, r: 1, g: 1, b: 1, a: 0.8) }

  it 'Raises an error if there is a wrong colorspace type' do
    expect { Relax::Color.new(:rgb, r: 1, g: 1, b: 1, a: 0.8) }
      .to raise_error Relax::Errors::Color::InvalidColorspace
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

  it 'Has one instance of Relax::Rgba and one of Relax::Hsl' do
    expect(my_color.rgba).to be_a Relax::Rgba
    expect(my_color.hsl).to be_a Relax::Hsl
  end
end

describe 'Changing color' do
  let(:my_color) { Relax::Color.new(:rgba, r: 1, g: 1, b: 1, a: 0.8) }

  it 'Updates rgba channels value' do
    my_color.rgba_to red: 100, green: 120, blue: 220, alpha: 0.2
    expect(my_color.rgba.to_a).to eq [100, 120, 220, 0.2]
    expect(my_color.hsl.to_a).to eq [230, 63, 63]
  end

  it 'Updates hsl channels value' do
    my_color.hsl_to hue: 100, saturation: 80, lightness: 40
    expect(my_color.hsl.to_a).to eq [100, 80, 40]
    expect(my_color.rgba.to_a).to eq [75, 184, 20, 0.8]
  end
end
