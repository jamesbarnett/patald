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
    self.origin = Geometry::Point[500, 32 * 72]
    self.scye = scye
    self.neck = neck
    self.chest = chest
    self.neck_to_waist = neck_to_waist
    self.shirt_length = shirt_length
    self.center_back = center_back
    self.seam_allowance = seam_allowance

    points[1] = Geometry::Point[origin.x, -neck_offset]
    print_point(points[1], "Point 1")
    points[2] = Geometry::Point[origin.x, -(scye + points[1].y)]
    print_point(points[2], "Point 2")
    points[3] = Geometry::Point[origin.x, -(neck_to_waist + points[1].y)]
    print_point(points[3], "Point 3")

    #points[4] = Geometry::Point[origin.x,
                                # -(shirt_length + 2.0 * seam_allowance + points[1].y)]
    # points[5] = Geometry::Point[origin.first,
                                # -(quarter_chest(torso_ease).y + points[1].y)]
    # points[6] = Geometry::Point[points[5].x, points[5].y]
    # points[7] = Geometry::Point[points[5].x, points[3].y]
    # points[8] = Geometry::Point[points[5].x, points[4].y]

    # Above should possibly be extracted into "base grid" method
    # quarter_chest(torso_ease)
    # back_work
  end

  def print_point(pt, msg)
    puts "#{msg.blank? ? "" : "#{msg} " }Point: (#{pt.x}, #{pt.y})"
  end

  def quarter_chest(ease)
    Geometry::Point[0, 0.25 * chest + ease * seam_allowance]
  end

  def back_work
    points[9] = Geometry::Point[(0.2 * neck), points[1].y]
    points[10] = Geometry::Point[(0.2 * neck), origin.y]
    # back of neck curve work goes here.

    sleeve_adjustment_line_y = (0.5 * (points[1].y + points[2].y))
    self.points[11] = Geometry::Point[points[1].x, sleeve_adjustment_line_y]
    # Consider splitting into front bodice pattern, rear bodice pattern, and sleeve pattern
    self.points[12] = Geometry::Point[points[1].x + center_back + seam_allowance, 
                                      sleeve_adjustment_line_y]
  end

  def size
    # Keeping it simple for now, just 24x30 inches
    [24 * 72, 30 * 72]
    #[48 * 72, 60 * 72]
  end
end

if $0 == $__FILE__
  x = SimpleBodice.new(16.0, 41.0, 20.0, 29.0, 8.5, 8.0, 2.0)
  puts "x is #{x.inspect}"
end
