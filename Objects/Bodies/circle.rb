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
  
  def in_front_of(body, distance)
    vector_distance = body.direction.with_norm(distance)
    @x = body.x + vector_distance.x
	@y = body.y + vector_distance.y
	@direction = body.direction
  end
  
  
  ##Collision
  def holds?(px, py)
    return Gosu::distance(px, py, @x, @y) <= @radius
  end
  
  def intersects?(segment)
    ax, ay, bx, by = segment
	ab = Vector.new(bx - ax, by - ay)
    ac = Vector.new(@x - ax, @y - ay)
	s = (ab * ac) / ab.norm()   #scalar proyection
	if s < 0
	  closest = Vector.new(0, 0)
	elsif s > ab.norm()
	  closest = ab
	else
	  closest = ab.unit_vector() * s
	end
	return ac.distance(closest) <= @radius
  end
  
  def collides?(body)
    if body.is_a?(InverseCircle)
	  inverse_circle = body
	  return inverse_circle.collides?(self)
	elsif body.is_a?(Circle)
	  circle = body
	  return Gosu::distance(@x, @y, circle.x, circle.y) <= @radius + circle.radius
	elsif body.is_a?(Polygon)
	  polygon = body
	  return polygon.holds?(@x, @y) ||
	         polygon.segments.any? { |segment| self.intersects?(segment) }
	else
	  raise "Body not recognized for collision with circle"
	end
  end
  
  
  ##Loop
  def draw()
	stp = @radius/15.0
	[-1,1].each do |sign|
	  (-@radius...@radius).step(stp) do |x|
	    ax = @x + x
		ay = @y + sign * Math.sqrt(@radius**2 - x**2)
		bx = @x + x + stp
		by = @y + sign * Math.sqrt(@radius**2 - ((x + stp).round)**2)
	    Gosu::draw_line(ax, ay, @c, bx, by, @c, 100)
	  end
	end
  end
end