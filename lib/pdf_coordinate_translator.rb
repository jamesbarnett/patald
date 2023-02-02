#!/usr/bin/env ruby\

#
# Translates from inches to pdf points and corrects for axis orientation
#
class PdfCoordinateTranslator
  attr_accessor :points, :width, :height

  def initialize(points, width, height)
    self.width = width
    self.height = height
    self.points = translate(points)
  end

  def translate(points)
    points.map do |pt, v|
      { pt => Geometry::Point[v.x, height - v.y] }
    end
  end
end

