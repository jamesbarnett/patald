#!/usr/bin/env ruby

require 'geometry'

class SimpleBodice
  include Geometry

  attr_accessor :customer_id, :neck, :chest, :shoulders, :scye, :neck_to_waist, :shirt_length,
                :center_back, :bicep, :wrist, :long_sleeve_length, :short_sleeve_length, 
                :neck_offset, :origin, :seam_allowance, :points
  
  def initialize(neck, chest, neck_to_waist, shirt_length, scye, center_back,
      torso_ease, neck_offset = 1.25, seam_allowance = 0.5)
    self.points = {}
    self.origin = Geometry::Point[0, 0]
    self.scye = scye
    self.neck = neck
    self.chest = chest
    self.neck_to_waist = neck_to_waist
    self.shirt_length = shirt_length
    self.center_back = center_back
    self.seam_allowance = seam_allowance
    self.points[1] = Geometry::Point[self.origin.x, neck_offset]
    self.points[2] = Geometry::Point[self.origin.x, self.scye + self.points[1].y]
    self.points[3] = Geometry::Point[self.origin.x, self.neck_to_waist + self.points[1].y]
    self.points[4] = Geometry::Point[self.origin.x, 
      self.shirt_length + 2.0 * seam_allowance + self.points[1].y]
    self.points[5] = Geometry::Point[self.origin.first, self.quarter_chest(torso_ease).y + self.points[1].y]
    self.points[6] = Geometry::Point[self.points[5].x, self.points[5].y]
    self.points[7] = Geometry::Point[self.points[5].x, self.points[3].y]
    self.points[8] = Geometry::Point[self.points[5].x, self.points[4].y]

    # Above should possibly be extracted into "base grid" method
    self.quarter_chest(torso_ease)
    self.back_work
  end

  def quarter_chest ease
    Geometry::Point[0, self.chest / 4.0 + 2.0 * self.seam_allowance]
  end

  def back_work
    self.points[9] = Geometry::Point[(self.neck / 5.0), self.points[1].y]
    self.points[10] = Geometry::Point[(self.neck / 5.0), self.origin.y]
    # back of neck curve work goes here.

    # self.point11 = Geometry::Point[self.point((self.point1.y + self.point2.y) / 2.0)]
    # Consider splitting into front bodice pattern, rear bodice pattern, and sleeve pattern
  end
end

if __FILE__ == $0
  x = SimpleBodice.new(16.0, 41.0, 20.0, 29.0, 8.5, 8.0, 2.0)
  puts "x is #{x.inspect}"
end
