#!/usr/bin/env ruby

require 'geometry'
require 'prawn'

# outputs to PDF
class PdfFormatter
  include Geometry

  attr_accessor :doc

  def initialize(doc)
    self.doc = doc
  end

  def render(h)
    doc.stroke do
      puts "Moving to first point"

      doc.move_to h.first.last.x, h.first.last.y

      h.each_key do |point|
        puts "line_to: #{h[point].x} #{h[point].y}"
        doc.line_to(h[point].x, h[point].y) if point != h.keys.first
      end

      doc.line_to h.first.last.x, h.first.last.y
    end
  end
end

if __FILE__ == $0
  Prawn::Document.generate("hello.pdf") do |doc|
    doc.text 'Hello World!'
    formatter = PdfFormatter.new doc
    formatter.render({ 1 => Geometry::Point[10, 10], 
                       2 => Geometry::Point[100, 100] })

  end

  `evince hello.pdf`
end
