class Circle
  include Constants
  attr_accessor :x, :y, :radius, :c
  
  ##CONSTRUCTOR  
  def initialize(x, y, radius, c = YELLOW)
    @x = x
	@y = y
	@radius = radius
	@c = c
  end
  
  
  ##COLLISION
  def holds?(point, x, y)
    return Gosu::distance(point[:x], point[:y], x, y) <= @radius
  end
  
  def intersects?(seg, x, y)
    #Initialize points as vectors and calculate from a
	ab = Vector.new(seg.b) - Vector.new(seg.a)
    ac = Vector.new({ :x => x, :y => y}) - Vector.new(seg.a)
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
  
  def collides?(shape, x, y)
    if shape.is_a?(Circle)
	  circle = shape
	  return distance(x, y, shape.x, shape.y) <= @radius + circle.radius
	elsif shape.is_a?(Polygon)
	  polygon = shape
	  return polygon.holds?({ :x => @x, :y => @y }) ||
	         polygon.segments.any? { |seg| self.intersects?(seg) }
	else
	  raise "Shape not recognized for collision with circle"
	end
  end
  
  
  ##SHOW
  def draw()
	stp = @radius/15.0
	[-1,1].each do |sign|
	  (-@radius...@radius).step(stp) do |x|
	    a = { :x => x,  :y => sign * Math.sqrt(radius**2 - x**2) }
	    b = { :x => x + stp,  :y => sign * circ_f((x + stp).round, @radius) }
	    a[:x] += @x
	    a[:y] += @y
	    b[:x] += @x
	    b[:y] += @y
	    Gosu::draw_line(a[:x], a[:y], @c, b[:x], b[:y], @c, 100)
	  end
	end
  end
end