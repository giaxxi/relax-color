# frozen_string_literal: true

require_relative '../lib/relax-color.rb'

describe 'SVG clsses atributes' do
  context Relax::SVG::Image do
    it 'Should not have duplicated attibutes' do
      expect(Relax::SVG::Image::ATTRIBUTES.size)
        .to be Relax::SVG::Image::ATTRIBUTES.compact.size
    end
  end

  context Relax::SVG::Container::Svg do
    it 'Should not have duplicated attibutes' do
      expect(Relax::SVG::Container::Svg::ATTRIBUTES.size)
        .to be Relax::SVG::Container::Svg::ATTRIBUTES.compact.size
    end
  end

  context Relax::SVG::Container::Group do
    it 'Should not have duplicated attibutes' do
      expect(Relax::SVG::Container::Group::ATTRIBUTES.size)
        .to be Relax::SVG::Container::Group::ATTRIBUTES.compact.size
    end
  end

  context Relax::SVG::Graphic::Rect do
    it 'Should not have duplicated attibutes' do
      expect(Relax::SVG::Graphic::Rect::ATTRIBUTES.size)
        .to be Relax::SVG::Graphic::Rect::ATTRIBUTES.compact.size
    end
  end
end
