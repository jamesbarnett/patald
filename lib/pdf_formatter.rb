#!/usr/bin/env ruby

require 'geometry'
require 'pathname'
require 'prawn'
require 'prawn/measurement_extensions'
require_relative 'simple_bodice'

# outputs to PDF
class PdfFormatter
  include Geometry

  attr_accessor :doc

  def initialize(doc)
    self.doc = doc
  end

  def render(h)
    # TODO: Need a coordinate translation class
    doc.stroke do
      # doc.move_to h.first.last.x.send(:in), h.first.last.y.send(:in)
      doc.move_to point_to_inches(h.first.last)

      h.each_key do |point|
        # Need to put some thinking into this for curves
        puts "Point: #{h[point]}"
        doc.line_to(point_to_inches(h[point])) if point != h.keys.first
      end

      doc.line_to point_to_inches(h.first.last)
    end
  end

  def point_to_inches(pt)
    [pt.x.send(:in), pt.y.send(:in)]
  end
end

if __FILE__ == $0
  fn = 'hello.pdf'
  x = SimpleBodice.new(16.0, 41.0, 20.0, 29.0, 8.5, 8.0, 2.0)
  Prawn::Document.generate(fn, page_size: x.size, layout: :portrait) do |doc|
    doc.text 'Hello World!'
    formatter = PdfFormatter.new doc
    formatter.render(x.points)
  end

  `evince #{fn}`
end

