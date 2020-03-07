# frozen_string_literal: true

require_relative '../lib/relax-color.rb'

describe 'SVG clsses atributes' do
  context Relax::SVG::Image do
    it 'Should not have duplicated attibutes' do
      expect(Relax::SVG::Image::ATTRIBUTES.size)
        .to be Relax::SVG::Image::ATTRIBUTES.compact.size
    end
  end

  context Relax::SVG::Structural::Svg do
    it 'Should not have duplicated attibutes' do
      expect(Relax::SVG::Structural::Svg::ATTRIBUTES.size)
        .to be Relax::SVG::Structural::Svg::ATTRIBUTES.compact.size
    end
  end

  context Relax::SVG::Structural::Group do
    it 'Should not have duplicated attibutes' do
      expect(Relax::SVG::Structural::Group::ATTRIBUTES.size)
        .to be Relax::SVG::Structural::Group::ATTRIBUTES.compact.size
    end
  end

  context Relax::SVG::Shape::Rect do
    it 'Should not have duplicated attibutes' do
      expect(Relax::SVG::Shape::Rect::ATTRIBUTES.size)
        .to be Relax::SVG::Shape::Rect::ATTRIBUTES.compact.size
    end
  end
end
