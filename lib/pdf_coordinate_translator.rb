#!/usr/bin/env ruby\


# Translates from inches to pdf points and corrects for axis orientation
#
class PdfCoordinateTranslator
  attr_accessor :points, :width, :height
  PPI = 72
  def initialize(points, width, height)
    self.width = width * PPI
    self.height = height * PPI
    self.points = translate(points)
  end

  def translate(points)
    points.map {|e| Geometry::Point[e.x * PPI, height - e.y] }
  end
end

