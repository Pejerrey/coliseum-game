class Polygon
  include Constants
  attr_accessor :x, :y, :direction, :zero_vertex, :c
  
  ##CONSTRUCTOR
  def initialize(x, y, zero_vertex, c = RED)
    @x = x
	@y = y
	@direction = Vector.new(0, -1)
	@zero_vertex = zero_vertex
	@c = c
	raise "Less than three vertex provided" if @zero_vertex.size < 6
  end
  
  
  ##ACCESSORS
  def vertex
    real_vertex = []
	@zero_vertex.each_slice(2) do |vertex|
	  x, y = vertex
	  temp = Vector.new(x, y)
	  temp.angle += @direction.angle
	  real_vertex << temp.x + @x << temp.y + @y
	end
	return real_vertex
  end
  
  def segments
    real_vertex = vertex()
    segments = []
    (0...real_vertex.size-3).step(2).each do |i|
	  segments << real_vertex.slice(i..i+3)
	end
    ax, ay = real_vertex.last(2)
	bx, by = real_vertex.first(2)
	segments << [ax, ay, bx, by]
    return segments
  end
  
  
  ##TRANSFORMATION
  def move_to(x, y)
    @x = x
	@y = y
  end
  
  def advance(x, y)
    @x += x
	@y += y
  end
  
  def apply(vector)
    @x += vector.x
	@y += vector.y
  end
  
  def scale(scalar)
    @zero_vertex.map!{ |x| x * scalar }
  end
  
  
  ##COLLISION
  def holds?(px, py)
     #Vertical ray casting from above
	y_edges = []
	segments.each do |segment|
	  ax, ay, bx, by = segment
	  if ax - bx != 0              	  #Disregard vertical segments
	    if Utils.in_between?(px, ax, bx)  #Ray and segment may intersect
		  edge = ay + (px - ax) * ((ay - by)/(ax - bx))
		  y_edges << edge if edge < py
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
	     #Case both vertical segments 
	    if ax == bx && p_ax == p_bx
		  return true if ax == p_ax &&                        #Aligned
		                 Utils.in_between?(ay, p_ay, p_by)    #Touches
		 #Case "seg" vertical
		elsif ax == bx && p_ax != p_bx
		  ps_slope = (p_ay - p_by)/(p_ax - p_bx)
	      ps_intercept = p_ay - ps_slope * p_ax
		  collision_x = ax
		  collision_y = ps_slope * collision_x + ps_intercept
		  return true if Utils.in_between?(collision_y, ay, by) &&
			             Utils.in_between?(collision_x, p_ax, p_bx)
		 #Case "p_seg" vertical
		elsif ax != bx && p_ax == p_bx
		  s_slope = (ay - by)/(ax - bx)
	      s_intercept = ay - s_slope * ax
		  collision_x = p_ax
		  collision_y = s_slope * collision_x + s_intercept
		  return true if Utils.in_between?(collision_x, ax, bx) &&
			             Utils.in_between?(collision_y, p_ay, p_by)
		 #Case none vertical
		elsif ax != bx && p_ax != p_bx
	      s_slope = (ay - by)/(ax - bx)
	      s_intercept = ay - s_slope * ax #b = y - mx
	      ps_slope = (p_ay - p_by)/(p_ax - p_bx)
	      ps_intercept = p_ay - ps_slope * p_ax
	      unless s_slope == ps_slope
		    collision_x = (ps_intercept - s_intercept)/(s_slope - ps_slope)
		    return true if Utils.in_between?(collision_x, ax, bx) &&
			               Utils.in_between?(collision_x, p_ax, p_bx)
	      else
		    return true if s_intercept == ps_intercept &&
			               Utils.in_between?(ax, p_ax, p_bx)
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
  
  
  ##SHOW
  def draw()
    segments.each do |segment|
	  ax, ay, bx, by = segment
	  Gosu::draw_line(ax, ay, @c, bx, by, @c, 100)
	end
	(@direction*20).draw(@x, @y, FUCHSIA)
  end
end