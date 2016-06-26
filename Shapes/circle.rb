class Circle
  include Shape
  include Constants
  
  #Initialization
  attr_accessor :x, :y, :radius, :color
  def initialize(x, y, radius, color = YELLOW)
    @x = x
	@y = y
	@radius = radius
	@color = color
  end
  
  #Collision
  def holds?(point)
    return Gosu::distance(point[:x], point[:y], @x, @y) <= @radius
  end
  
  def intersects?(seg)
    #Initialize points as vectors
	a = Vector.new(seg.a)
	b = Vector.new(seg.b)
	c = Vector.new({ :x => @x, :y => @y})
	#Work from the beginning of the segment
	ab = b - a
    ac = c - a
	#Get the scalar proyection from ac to ab
	s = (ab * ac) / ab.norm()
	if s < 0
	  closest = Vector.new({ :x => 0, :y => 0 })
	elsif s > ab.norm()
	  closest = ab
	else
	  closest = ab.unit_vector() * s #Proyection
	end
	return ac.distance(closest) <= @radius
  end
  
  def collides?(shape)
    if shape.is_a?(Circle)
	  circle = shape
	  return distance(@x, @y, shape.x, shape.y) <= @radius + circle.radius
	elsif shape.is_a?(Polygon)
	  polygon = shape
	  if polygon.holds?({ :x => @x, :y => @y })
	    return true
	  elsif polygon.segments.any? { |seg| self.intersects?(seg) }
	    return true
	  else
	    return false
	  end
	else
	  raise "Shape not recognized for collision with circle"
	end
  end
  
  #Indirect Attributes
  def width() @radius * 2 end
  def height() @radius * 2 end
  def left() @x - @radius/2 end
  def right() @x + @radius/2 end
  def top() @y - @radius/2 end
  def bottom() @y + @radius/2 end
  def left=(left) @x = left + @radius/2 end
  def right=(right) @x = right - @radius/2 end
  def top=(top) @y = top + @radius/2 end
  def bottom=(bottom) @y = bottom - @radius/2 end
  
  #Draw
  def draw()
    Utils.draw_circ(self) if $DEBUG_MODE
  end
end