#!/usr/bin/env ruby

#
#
#
class PatternComponent
  attr_accessor :points
  
  def initialize
    self.points = []
  end

  def add_point(x, y)
    self.points << Geometry::Point[x, y]
  end
end
