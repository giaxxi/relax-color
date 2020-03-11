# frozen_string_literal: true

require_relative '../lib/relax-color.rb'
class Dummy
  include Relax::Validator::SVG
end

describe Relax::SVG::Shape::PathData do
  let(:invalid_point) { Relax::Errors::SVG::InvalidPoint }
  let(:validate) { Dummy.new }
  it 'Should return a valid point' do
    point = [1, 1]
    expect(validate.validate_point(point)).to be point
  end
  it 'Should raise Relax::Errors::SVG::InvalidPoint (1)' do
    point = [1, '1']
    expect { validate.validate_point(point) }.to raise_error invalid_point
  end
  it 'Should raise Relax::Errors::SVG::InvalidPoint (2)' do
    point = [1, 1, 1]
    expect { validate.validate_point(point) }.to raise_error invalid_point
  end
  it 'Should raise Relax::Errors::SVG::InvalidPoint (3)' do
    point = 1
    expect { validate.validate_point(point) }
      .to raise_error invalid_point
  end
end

describe Relax::SVG::Shape::PathData do
  context 'move_to' do
    let(:path_data) { Relax::SVG::Shape::PathData.new }
    it 'Should properly format move_to relative' do
      path_data.move_to rel: [1, 1]
      expect(path_data.data).to eql 'm1,1'
    end
    it 'Should properly format move_to absolute' do
      path_data.move_to abs: [10, 10]
      expect(path_data.data).to eql 'M10,10'
    end
    it 'Should properly format chained move_to' do
      path_data.move_to(abs: [10, 10]).move_to(rel: [20, 20])
      expect(path_data.data).to eql 'M10,10 m20,20'
    end
    it 'Should properly format chained move_to while instantiating' do
      path_data = Relax::SVG::Shape::PathData.new do |pd|
        pd.move_to abs: [10, 10]
        pd.move_to rel: [20, 20]
      end
      expect(path_data.data).to eql 'M10,10 m20,20'
    end
  end
end

describe Relax::SVG::Shape::PathData do
  context 'line_to' do
    let(:path_data) { Relax::SVG::Shape::PathData.new }
    it 'Should properly format line_to relative' do
      path_data.line_to rel: [1, 1]
      expect(path_data.data).to eql 'l1,1'
    end
    it 'Should properly format move_to_absolute' do
      path_data.line_to abs: [10, 10]
      expect(path_data.data).to eql 'L10,10'
    end
    it 'Should properly format chained line_to' do
      path_data.line_to(abs: [10, 10]).line_to(rel: [20, 20])
      expect(path_data.data).to eql 'L10,10 l20,20'
    end
    it 'Should properly format chained move_to while instantiating' do
      path_data = Relax::SVG::Shape::PathData.new do |pd|
        pd.line_to abs: [10, 10]
        pd.line_to rel: [20, 20]
      end
      expect(path_data.data).to eql 'L10,10 l20,20'
    end
  end
end

describe Relax::SVG::Shape::PathData do
  context 'line_to horizontal' do
    let(:path_data) { Relax::SVG::Shape::PathData.new }
    it 'Should properly format line_to relative' do
      path_data.line_to rel: [1, :h]
      expect(path_data.data).to eql 'h1'
    end
    it 'Should properly format move_to_absolute' do
      path_data.line_to abs: [10, :horizontal]
      expect(path_data.data).to eql 'H10'
    end
    it 'Should properly format chained line_to' do
      path_data.line_to(abs: [10, :h]).line_to(rel: [20, :hor])
      expect(path_data.data).to eql 'H10 h20'
    end
    it 'Should properly format chained move_to while instantiating' do
      path_data = Relax::SVG::Shape::PathData.new do |pd|
        pd.line_to abs: [10, :hor]
        pd.line_to rel: [20, :h]
      end
      expect(path_data.data).to eql 'H10 h20'
    end
  end
end

describe Relax::SVG::Shape::PathData do
  context 'line_to vertical' do
    let(:path_data) { Relax::SVG::Shape::PathData.new }
    it 'Should properly format line_to relative' do
      path_data.line_to rel: [1, :v]
      expect(path_data.data).to eql 'v1'
    end
    it 'Should properly format move_to_absolute' do
      path_data.line_to abs: [10, :vertical]
      expect(path_data.data).to eql 'V10'
    end
    it 'Should properly format chained line_to' do
      path_data.line_to(abs: [10, :v]).line_to(rel: [20, :ver])
      expect(path_data.data).to eql 'V10 v20'
    end
    it 'Should properly format chained move_to while instantiating' do
      path_data = Relax::SVG::Shape::PathData.new do |pd|
        pd.line_to abs: [10, :vertical]
        pd.line_to rel: [20, :v]
      end
      expect(path_data.data).to eql 'V10 v20'
    end
  end
end

describe Relax::SVG::Shape::PathData do
  context 'cubic curve_to' do
    let(:path_data) { Relax::SVG::Shape::PathData.new }
    it 'Should properly format curve_to relative' do
      path_data.curve_to rel: [100, 100], controls: [[10, 20], [30, 40]]
      expect(path_data.data).to eql 'c10,20 30,40 100,100'
    end
    it 'Should properly format move_to_absolute' do
      path_data.curve_to abs: [100, 100], controls: [[10, 20], [30, 40]]
      expect(path_data.data).to eql 'C10,20 30,40 100,100'
    end
    it 'Should properly format chained calls' do
      path_data
        .line_to(abs: [10, :v])
        .curve_to abs: [100, 100], controls: [[10, 20], [30, 40]]
      expect(path_data.data).to eql 'V10 C10,20 30,40 100,100'
    end
    it 'Should properly format chained calls while instantiating' do
      path_data = Relax::SVG::Shape::PathData.new do |pd|
        pd.curve_to abs: [100, 100], controls: [[10, 20], [30, 40]]
        pd.line_to rel: [20, 50]
      end
      expect(path_data.data).to eql 'C10,20 30,40 100,100 l20,50'
    end
  end
end
