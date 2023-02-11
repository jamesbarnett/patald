#!/usr/bin/env ruby

#
# Models a basic pattern component. A pattern component is closed geometric
# figure. A pattern is a collection of pattern components.
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
