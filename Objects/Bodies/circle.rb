class Circle
  include Constants
  
  attr_accessor :x, :y, :direction, :radius, :c
  
  ##Constructor
  def initialize(x, y, radius, c = YELLOW)
    @x = x
	@y = y
	@direction = Vector.new(0, -1)
	@radius = radius
	@c = c
  end
  
  
  ##Transformation
  def move_to(x, y)
    @x = x
	@y = y
  end
  
  def rotate_to(ang)
    @direction.angle = ang
  end
  
  def advance(x, y)
    @x += x
	@y += y
  end
  
  def turn(ang)
    @direction.angle += ang
  end
  
  def apply(vector)
    @x += vector.x
	@y += vector.y
  end
  
  def scale(scalar)
    @radius *= scalar
  end
  
  
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
  
  def collides?(body)
    if body.is_a?(InverseCircle)
	  inverse_circle = body
	  return inverse_circle.collides?(self)
	elsif body.is_a?(Circle)
	  circle = body
	  return Gosu::distance(x, y, circle.x, circle.y) <= @radius + circle.radius
	elsif body.is_a?(Polygon)
	  polygon = body
	  return polygon.holds?({ :x => @x, :y => @y }) ||
	         polygon.segments.any? { |seg| self.intersects?(seg) }
	else
	  raise "Body not recognized for collision with circle"
	end
  end
  
  
  ##Loop
  def draw()
	stp = @radius/15.0
	[-1,1].each do |sign|
	  (-@radius...@radius).step(stp) do |x|
	    a = { :x => x, :y => sign * Math.sqrt(@radius**2 - x**2) }
	    b = { :x => x + stp, :y => sign * Math.sqrt(@radius**2 - ((x + stp).round)**2) }
	    a[:x] += @x
	    a[:y] += @y
	    b[:x] += @x
	    b[:y] += @y
	    Gosu::draw_line(a[:x], a[:y], @c, b[:x], b[:y], @c, 100)
	  end
	end
	(direction*20).draw(@x, @y, FUCHSIA)
  end
end