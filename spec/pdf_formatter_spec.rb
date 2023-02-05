require 'spec_helper'

describe "PdfFormatter" do
  # it "draws a box" do
  # end
  #
  # it draws the first line correctly
  # it gets the coordinates successfully
  # it translates the coordinates successfully
  # it receives a new point
  it "adds a point" do
    pc = PatternComponent.new
    pt = Geometry::Point[1.0, -2.0] 
    pc.add_point(1.0, -2.0) 
    expect(pc.points.include?(pt)).to be_truthy
  end
end
