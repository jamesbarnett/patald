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
    pc = PatternComponent.new
    pt = Geometry::Point[1.0, -2.0]
    pc.add_point(1.0, -2.0)
    expect(pc.points.include?(pt)).to be_truthy
  end

  it 'translates a point' do
    pc = PatternComponent.new
    pt = Geometry::Point[1.0, -2.0]
    pc.add_point(1.0, -2.0)
    pf = PdfCoordinateTranslator.new(pc.points, 16.0, 32.0)
    expect(pf.translate.first).to eq(Geometry::Point[72.0, 2448.0])
    size = [72*32, 72*16]
    fn = "test.pdf"
    Prawn::Document.generate(fn, page_size: size, layout: :portrait) do |doc|
      doc.text "the cursor is here: #{doc.cursor}" # 1080 by default...
    
      doc.stroke do
        doc.move_to [0, 0]
        doc.line_to [0, 1080]
        doc.line_to [100, 1080]
      end
    end

    `evince #{fn}`
  end
end
