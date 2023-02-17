#!/usr/bin/env ruby\

require 'prawn/measurement_extensions'
require 'pattern_component'

# Translates from inches to pdf points and corrects for axis orientation
#
class PdfCoordinateTranslator
  attr_accessor :points, :width, :height, :doc
  PPI = 72
  def initialize(pattern_component, doc)
    self.width = pattern_component.width * PPI
    self.height = pattern_component.height * PPI
    self.points = pattern_component.points
    self.doc = doc
  end

  def translate
    points.map do |e|
      # puts "e (#{e}) => #{e.y * PPI + doc.page.margins}"
      t e
    end
  end

  def t(pt)
    Geometry::Point[pt.x * PPI, (height - (pt.y * PPI + doc.page.margins[:top] +
                                           doc.page.margins[:bottom]))]
  end

  def render
    translated = translate
    doc.stroke do 
      translated.each do |e|
        sym = (e == translated.first) ? :move_to : :line_to
        puts "Sym is #{sym}"
        doc.send(sym, e.x, e.y)
      end
    end
  end
end

