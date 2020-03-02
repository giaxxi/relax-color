# frozen_string_literal: true

require_relative '../lib/relax-color.rb'


describe Relax::SVG do
output =  '<svg xmlns="http://www.w3.org/2000/svg"' \
          'x="0" y="0" width="300" height="300">' \
          '<rect x="2" y="100" width="100" height="50" fill="#ff0050" />' \
          '<rect x="100" y="100" width="20" height="50" fill="cyan" />' \
          '<g element-id="piero">' \
          '<rect x="2" y="2" width="100" height="50" fill="silver" />' \
          '</g></svg>'

  rectangle = Relax::SVG::Graphic::Rect.new do |r|
    r.x = 2
    r.y = 2
    r.width = 100
    r.height = 50
    r.fill = 'silver'
  end

  group = Relax::SVG::Container::Group.new do |g|
    g.element_id = 'piero'
  end

  group.add_children do |g|
    g << rectangle.render
  end

  svg_container = Relax::SVG::Container::Svg.new do |c|
    c.x = 0
    c.y = 0
    c.width = 300
    c.height = 300
  end

  rectangle.fill = '#ff0050'
  rectangle.y = 100

  svg_container.add_children do |svg|
    svg << rectangle.render
    rectangle.then do |r|
      r.x = 100
      r.width = 20
      r.fill = 'cyan'
    end
    svg << rectangle.render
    svg << group.render
  end
  it 'Should return a correct output' do
    expect(svg_container.render).eql? output
  end
end
