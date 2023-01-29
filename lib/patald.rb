#!/usr/bin/env ruby

require 'geometry'

# base class for a quarter bodice component
class SimpleBodice
  include Geometry

  attr_accessor :customer_id, :neck, :chest, :shoulders, :scye, :neck_to_waist, :shirt_length,
                :center_back, :bicep, :wrist, :long_sleeve_length, :short_sleeve_length,
                :neck_offset, :origin, :seam_allowance, :points

  def initialize(neck,
                 chest,
                 neck_to_waist,
                 shirt_length,
                 scye,
                 center_back,
                 torso_ease,
                 neck_offset = 1.25,
                 seam_allowance = 0.5)
    self.points = {}
    self.origin = Geometry::Point[0, 0]
    self.scye = scye
    self.neck = neck
    self.chest = chest
    self.neck_to_waist = neck_to_waist
    self.shirt_length = shirt_length
    self.center_back = center_back
    self.seam_allowance = seam_allowance
    points[1] = Geometry::Point[origin.x, neck_offset]
    points[2] = Geometry::Point[origin.x, scye + points[1].y]
    points[3] = Geometry::Point[origin.x, neck_to_waist + points[1].y]
    points[4] = Geometry::Point[origin.x,
                                shirt_length + 2.0 * seam_allowance + points[1].y]
    points[5] = Geometry::Point[origin.first,
                                quarter_chest(torso_ease).y + points[1].y]
    points[6] = Geometry::Point[points[5].x, points[5].y]
    points[7] = Geometry::Point[points[5].x, points[3].y]
    points[8] = Geometry::Point[points[5].x, points[4].y]

    # Above should possibly be extracted into "base grid" method
    quarter_chest(torso_ease)
    back_work
  end

  def quarter_chest(ease)
    Geometry::Point[0, chest / 4.0 + ease * seam_allowance]
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
