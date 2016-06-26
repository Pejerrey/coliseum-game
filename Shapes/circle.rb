class Circle
  include Shape
  include Constants
  
  ##Initialization
  attr_accessor :x, :y, :radius, :color
  def initialize(x, y, radius, color = YELLOW)
    @x = x
	@y = y
	@radius = radius
	@color = color
  end
  
  ##Accessors
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
  
  ##Collision
  def holds?(point)
    return Gosu::distance(point[:x], point[:y], @x, @y) <= @radius
  end
  
  def intersects?(seg)
     #Initialize points as vectors and calculate from a
	ab = Vector.new(seg.b) - Vector.new(seg.a)
    ac = Vector.new({ :x => @x, :y => @y}) - Vector.new(seg.a)
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
	  return polygon.holds?({ :x => @x, :y => @y }) ||
	         polygon.segments.any? { |seg| self.intersects?(seg) }
	else
	  raise "Shape not recognized for collision with circle"
	end
  end
  
  ##Show
  def draw()
	stp = @radius/15.0
	[-1,1].each do |sign|
	  (-@radius...@radius).step(stp) do |x|
	    a = { :x => x,  :y => sign * circ_f(x, radius) }
	    b = { :x => x + stp,  :y => sign * circ_f((x + stp).round, @radius) }
	    a[:x] += @x
	    a[:y] += @y
	    b[:x] += @x
	    b[:y] += @y
	    Gosu::draw_line(a[:x], a[:y], color, b[:x], b[:y], color, 100)
	  end
	end
  end
  
  def circ_f(x, r) #Positive only
    return Math.sqrt(r**2 - x**2)
  end
end