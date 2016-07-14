class Polygon
  include Constants
  
  attr_accessor :x, :y, :direction, :zero_vertex, :c
  
  ##Constructor
  def initialize(x, y, zero_vertex, c = RED)
    @x = x
	@y = y
	@direction = Vector.new(0, -1)
	@zero_vertex = zero_vertex
	@c = c
	raise "Less than three vertex provided in poly initialization" if @zero_vertex.size < 6
	raise "Missing y value in polygon initialization" if @zero_vertex.size % 2 == 1
  end
  
  
  ##Accessors
  def vertex
    real_vertex = []
	@zero_vertex.each_slice(2) do |vertex|
	  x, y = vertex
	  norm = Gosu::distance(0, 0, x, y)
	  angle = Gosu::angle(0, 0, x, y)
	  x = Gosu::offset_x(angle + @direction.angle, norm)
      y = Gosu::offset_y(angle + @direction.angle, norm)
	  real_vertex << x + @x << y + @y
	end
	return real_vertex
  end
  
  def segments
    real_vertex = vertex()
    segments = []
    (0...real_vertex.size-3).step(2).each do |i|
	  segments << real_vertex.slice(i..i+3)
	end
	segments << real_vertex.last(2) + real_vertex.first(2)
    return segments
  end
  
  
  ##Transformations
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
    @zero_vertex.map!{ |x| x * scalar }
  end
  
  def in_front_of(body, distance)
    vector_distance = body.direction.with_norm(distance)
    @x = body.x + vector_distance.x
	@y = body.y + vector_distance.y
	@direction = body.direction
  end
  
  
  ##Collision
  def holds?(px, py)
    #vertical ray casting from above
	y_edges = []
	segments.each do |segment|
	  ax, ay, bx, by = segment
	  if ax - bx != 0              	      #disregard vertical segments
	    if px.in_between?(ax, bx)         #ray and segment may intersect
		  edge = ay + (px - ax) * ((ay - by)/(ax - bx))
		  y_edges << edge if edge < py    #From above only
	    end
	  end
	end
	return y_edges.size % 2 == 1
  end
  
  def intersects?(segment)
    ax, ay, bx, by = segment
    if holds?(ax, ay) || holds?(bx, by)
	  return true
	else
	  segments.each do |polygon_segment|
	    p_ax, p_ay, p_bx, p_by = polygon_segment
	     #both segments vertical  
	    if ax == bx && p_ax == p_bx
		  return true if ax == p_ax && ay.in_between?(p_ay, p_by)
		 #segment vertical
		elsif ax == bx && p_ax != p_bx
		  ps_slope = (p_ay - p_by)/(p_ax - p_bx)
	      ps_intercept = p_ay - ps_slope * p_ax
		  collision_x = ax
		  collision_y = ps_slope * collision_x + ps_intercept
		  return true if collision_y.in_between?(ay, by) &&
			             collision_x.in_between?(p_ax, p_bx)
		 #polygon segment vertical
		elsif ax != bx && p_ax == p_bx
		  s_slope = (ay - by)/(ax - bx)
	      s_intercept = ay - s_slope * ax
		  collision_x = p_ax
		  collision_y = s_slope * collision_x + s_intercept
		  return true if collision_x.in_between?(ax, bx) &&
			             collision_y.in_between?(p_ay, p_by)
		 #no segment vertical
		elsif ax != bx && p_ax != p_bx
	      s_slope = (ay - by)/(ax - bx)
	      s_intercept = ay - s_slope * ax #b = y - mx
	      ps_slope = (p_ay - p_by)/(p_ax - p_bx)
	      ps_intercept = p_ay - ps_slope * p_ax
	      unless s_slope == ps_slope
		    collision_x = (ps_intercept - s_intercept)/(s_slope - ps_slope)
		    return true if collision_x.in_between?(ax, bx) &&
			               collision_x.in_between?(p_ax, p_bx)
	      else
		    return true if s_intercept == ps_intercept &&
			               ax.in_between?(p_ax, p_bx)
		  end
		end
	  end
	end
	return false
  end
  
  def collides?(body)
	if body.is_a?(InverseCircle)
	  inverse_circle = body
	  return inverse_circle.collides?(self)
    elsif body.is_a?(Polygon)
	  polygon = body
	  return segments.any? { |segment| polygon.intersects?(segment) } ||
	         polygon.segments.any? { |segment| intersects?(segment) }
	elsif body.is_a?(Circle)
	  circle = body
	  return circle.collides?(self)
	else
	  raise "Body not recognized for collision with polygon"
	end
  end
  
  
  ##Loop
  def draw()
    segments.each do |segment|
	  ax, ay, bx, by = segment
	  Gosu::draw_line(ax, ay, @c, bx, by, @c, 100)
	end
  end
end