#!/usr/bin/env ruby

require 'geometry'
require 'prawn'

# outputs to PDF
class PdfFormatter
  include Geometry

  def initialize # brush options and stuff?)

  end

  def render(h)
    h.each_key do |point|
      # draw to point.x, point.y -- until curves anyway
    end

    # draw to h[h.keys.first].(x,y) to close figure
  end
end

if __FILE__ == $0
  formatter = PdfFormatter.new
  formatter.render({ 1 => Geometry::Point[1, 1], 
                     2 => Geometry::Point[10, 10] })

  Prawn::Document.generate("hello.pdf") do
    text 'Hello World!r'
  end
  # save stream to disk
  # spawn proc to view result.
end
