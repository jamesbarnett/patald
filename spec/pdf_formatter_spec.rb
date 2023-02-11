require 'geometry'
require 'spec_helper'
require 'pattern_component'
require 'pdf_coordinate_translator'

describe 'PdfCoordinateTranslator' do
  # it "draws a box" do
  # end
  #
  # it draws the first line correctly
  # it gets the coordinates successfully
  # it translates the coordinates successfully
  # it receives a new point
  it 'adds a point' do
    pc = PatternComponent.new
    pt = Geometry::Point[1.0, -2.0]
    pc.add_point(1.0, -2.0)
    expect(pc.points.include?(pt)).to be_truthy
  end

  it 'translates a point' do
    pc = PatternComponent.new
    pt = Geometry::Point[1.0, -2.0]
    pc.add_point(1.0, -2.0)
    pf = PdfCoordinateTranslator.new(pc.points, 32.0, 16.0)
  end
end
