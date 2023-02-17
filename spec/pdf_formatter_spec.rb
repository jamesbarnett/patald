# frozen_string_literal: true

require 'geometry'
require 'spec_helper'
require 'pattern_component'
require 'pdf_coordinate_translator'
require 'prawn'
require 'prawn/measurement_extensions'

describe 'PdfCoordinateTranslator' do
  # it "draws a box" do
  # end
  #
  # it draws the first line correctly
  # it gets the coordinates successfully
  # it translates the coordinates successfully
  # it receives a new point
  it 'adds a point' do
    pc = PatternComponent.new(8, 10)
    pt = Geometry::Point[1.0, -2.0]
    pc.add_point(1.0, -2.0)
    expect(pc.points.include?(pt)).to be_truthy
  end

  it 'translates a point' do
    pc = PatternComponent.new(16, 32)
    d = 6.5 
    pc.add_point(0, 0)
    pc.add_point(d, 0)
    pc.add_point(d, d)
    pc.add_point(0, d)
    pc.add_point(d, d)
    pc.add_point(0, d)
    pc.add_point(0, 0)
    pc.add_point(d, d)
    pc.add_point(0, d)
    pc.add_point(0, 0)

    size = [72*16, 72*32]
    fn = "test.pdf"

    Prawn::Document.generate(fn, page_size: size, layout: :portrait) do |doc|
      doc.text "the cursor is here: #{doc.cursor}"
      pf = PdfCoordinateTranslator.new pc, doc
      pf.render 
    end

    `evince #{fn}`
  end
end
