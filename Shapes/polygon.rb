class Polygon
  include Shape
  
  ##Constructor
  attr_accessor :x, :y
  def initialize(args)
    @x = args.shift
	@y = args.shift
    @vertex = []
	until args.empty?
	  vx = args.shift
	  vy = args.shift
	  raise "Odd number of argumens for vertex initialization" if vy == nil
	  @vertex << { :x => vx, :y => vy}
	end
	raise "Less than three vertex provided" if @vertex.size < 3
  end
  
  ##Accessors
  def zero_vertex
    @vertex
  end
  
  def zero_segments
    arr = []
    (0...vertex.size-1).each do |i|
	  a = zero_vertex[i]
	  b = zero_vertex[i+1]
	  arr << Segment.new(a[:x], a[:y], b[:x], b[:y])
	end
    a = zero_vertex.last
	b = zero_vertex.first
	arr << Segment.new(a[:x], a[:y], b[:x], b[:y])
	return arr
  end

  def vertex
    zero_vertex.map{ |v| { :x => v[:x] + @x, :y => v[:y] + @y} }
  end
  
  def segments
    zero_segments.map{ |s| Segment.new(s.a[:x] + @x, s.a[:y] + @y,
                                       s.b[:x] + @x, s.b[:y] + @y)}
  end
  
  ##Collision
  def holds?(point)
     #Vertical ray casting from above
	y_edges = []
	segments.each do |seg|
	  if seg.a[:x] - seg.b[:x] != 0                            #Disregard vertical segments
	    if Utils.in_between?(point[:x], seg.a[:x], seg.b[:x])  #Ray and segment may intersect
		  edge = seg.a[:y] + (point[:x] - seg.a[:x]) *
		         ((seg.a[:y] - seg.b[:y])/(seg.a[:x] - seg.b[:x]))
		  y_edges << edge if edge < point[:y]
	    end
	  end
	end
	return y_edges.size % 2 == 1
  end
  
  def intersects?(seg)
    if holds?(seg.a) || holds?(seg.b)
	  return true
	else
	  segments.each do |p_seg|
	     #Case both vertical segments 
	    if seg.a[:x] == seg.b[:x] && p_seg.a[:x] == p_seg.b[:x]
		  return true if seg.a[:x] == p_seg.a[:x] &&                               #Aligned
		                 Utils.in_between?(seg.a[:y], p_seg.a[:y], p_seg.b[:y])    #Touches
		 #Case "seg" vertical
		elsif seg.a[:x] == seg.b[:x] && p_seg.a[:x] != p_seg.b[:x]
		  ps_slope = (p_seg.a[:y] - p_seg.b[:y])/(p_seg.a[:x] - p_seg.b[:x])
	      ps_intercept = p_seg.a[:y] - ps_slope * p_seg.a[:x]
		  collision_x = seg.a[:x]
		  collision_y = ps_slope * collision_x + ps_intercept
		  return true if Utils.in_between?(collision_y, seg.a[:y], seg.b[:y]) &&
			             Utils.in_between?(collision_x, p_seg.a[:x], p_seg.b[:x])
		 #Case "p_seg" vertical
		elsif seg.a[:x] != seg.b[:x] && p_seg.a[:x] == p_seg.b[:x]
		  s_slope = (seg.a[:y] - seg.b[:y])/(seg.a[:x] - seg.b[:x])
	      s_intercept = seg.a[:y] - s_slope * seg.a[:x]
		  collision_x = p_seg.a[:x]
		  collision_y = s_slope * collision_x + s_intercept
		  return true if Utils.in_between?(collision_x, seg.a[:x], seg.b[:x]) &&
			             Utils.in_between?(collision_y, p_seg.a[:y], p_seg.b[:y])
		 #Case none vertical
		elsif seg.a[:x] != seg.b[:x] && p_seg.a[:x] != p_seg.b[:x]
	      s_slope = (seg.a[:y] - seg.b[:y])/(seg.a[:x] - seg.b[:x])
	      s_intercept = seg.a[:y] - s_slope * seg.a[:x] #b = y - mx
	      ps_slope = (p_seg.a[:y] - p_seg.b[:y])/(p_seg.a[:x] - p_seg.b[:x])
	      ps_intercept = p_seg.a[:y] - ps_slope * p_seg.a[:x]
	      unless s_slope == ps_slope
		    collision_x = (ps_intercept - s_intercept)/(s_slope - ps_slope)
		    return true if Utils.in_between?(collision_x, seg.a[:x], seg.b[:x]) &&
			               Utils.in_between?(collision_x, p_seg.a[:x], p_seg.b[:x])
	      else
		    return true if s_intercept == ps_intercept &&
			               Utils.in_between?(seg.a[:x], p_seg.a[:x], p_seg.b[:x])
		  end
		end
	  end
	end
	return false
  end
  
  def collides?(shape)
    if shape.is_a?(Polygon)
	  polygon = shape
	  return segments.any? { |seg| polygon.intersects?(seg) } ||
	         polygon.segments.any? { |seg| intersects?(seg) }
	elsif shape.is_a?(Circle)
	  circle = shape
	  return circle.collides?(self)
	else
	  raise "Shape not recognized for collision with polygon"
	end
  end
  
  ##Show
  def draw()
    segments.each { |segment| segment.draw() }
  end
end