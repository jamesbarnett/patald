#!/usr/bin/env ruby

$:.unshift(File.join(Dir.pwd, ".."))

require 'geometry'
require 'pathname'
require 'prawn'
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
      doc.move_to h.first.last.x, h.first.last.y

      h.each_key do |point|
        # Need to put some thinking into this for curves
        doc.line_to(h[point].x, h[point].y) if point != h.keys.first
      end

      doc.line_to h.first.last.x, h.first.last.y
    end
  end
end

if __FILE__ == $0
  x = SimpleBodice.new(16.0, 41.0, 20.0, 29.0, 8.5, 8.0, 2.0)
  Prawn::Document.generate("hello.pdf") do |doc|
    doc.text 'Hello World!'
    formatter = PdfFormatter.new doc
    formatter.render(x.points)
  end

  `evince hello.pdf`
end
