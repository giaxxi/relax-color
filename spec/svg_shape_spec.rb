# frozen_string_literal: true

require_relative '../lib/relax-color.rb'
class Dummy
  include Relax::Validator::SVG
end

describe Relax::SVG::Shape do
  context Relax::SVG::Shape::Polyline do
    let(:poly) { Relax::SVG::Shape::Polyline.new }
    it 'Should return a valid polyline' do
      poly.points = [[1, 2], [2, 3], [3, 4]]
      expect(poly.points).to eq '1,2 2,3 3,4'
    end

    it 'Should raise invalid points' do
      expect { poly.points = '[[1, 2], [2, 3], [3, 4]]' }
        .to raise_error Relax::Errors::SVG::InvalidPoints
    end

    it 'Should raise invalid points' do
      expect { poly.points = [[1, 2], [2, 3], [3, '4']] }
        .to raise_error Relax::Errors::SVG::InvalidPoint
    end
  end
end

describe Relax::SVG::Shape do
  context Relax::SVG::Shape::Polygon do
    let(:poly) { Relax::SVG::Shape::Polygon.new }
    it 'Should return a valid polygon' do
      poly.points = [[1, 2], [2, 3], [3, 4]]
      expect(poly.points).to eq '1,2 2,3 3,4'
    end

    it 'Should raise invalid points' do
      expect { poly.points = '[[1, 2], [2, 3], [3, 4]]' }
        .to raise_error Relax::Errors::SVG::InvalidPoints
    end

    it 'Should raise invalid points' do
      expect { poly.points = [[1, 2], [2, 3], [3, '4']] }
        .to raise_error Relax::Errors::SVG::InvalidPoint
    end
  end
end
