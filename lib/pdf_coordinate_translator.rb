#!/usr/bin/env ruby\

require 'prawn/measurement_extensions'

# Translates from inches to pdf points and corrects for axis orientation
#
class PdfCoordinateTranslator
  attr_accessor :points, :width, :height
  PPI = 72
  def initialize(points, width, height)
    self.width = width * PPI
    self.height = height * PPI
    self.points = points
  end

  def translate
    points.map {|e| Geometry::Point[e.x * PPI, height - (e.y * PPI)] }
  end
end

