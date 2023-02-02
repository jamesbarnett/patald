#!/usr/bin/env ruby

require 'geometry'
require 'pathname'
require 'prawn'
require 'prawn/measurement_extensions'
require_relative 'pdf_coordinate_translator'
require_relative 'simple_bodice'

# outputs to PDF
class PdfFormatter
  include Geometry

  attr_accessor :doc

  def initialize(doc)
    self.doc = doc
  end

  def render(h)
    doc.stroke do
      puts "h: #{h}"
      doc.move_to [h.first.x, h.first.y]

      # Need to put some thinking into this for curves
      h.each do |pt|
        doc.line_to [pt.x, pt.y] if [pt.x, pt.y] != h.first
      end

      doc.line_to [h.first.x, h.first.y]
    end
  end

  def translate(points, height)
    points.map do |_, v|
      puts "translate: x: #{v.x}, height - y: #{height - v.y}"
      Geometry::Point[v.x, height - v.y]
    end
  end
end

if __FILE__ == $0
  fn = 'test.pdf'
  x = SimpleBodice.new(16.0, 41.0, 20.0, 29.0, 8.5, 8.0, 2.0)
  # t = PdfCoordinateTranslator.new(x.points, x.size.first, x.size.last)
  puts "x.size: #{x.size}"
  Prawn::Document.generate(fn, page_size: x.size, layout: :portrait) do |doc|
    formatter = PdfFormatter.new doc
    x.points = formatter.translate x.points, x.size.last
    puts "X.points: #{x.points}"
    formatter.render(x.points)
  end

  `evince #{fn}`
end

