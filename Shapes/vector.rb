class Vector
  include Constants
  
  ##Constructor
  attr_accessor :x, :y, :c
  def initialize(args, c = GREEN)
    if args[:x] && args[:y]
	  @x = args[:x]
	  @y = args[:y]
	elsif args[:angle] && args[:norm]
	  @x = Gosu::offset_x(args[:angle], args[:norm])
	  @y = Gosu::offset_y(args[:angle], args[:norm])
	else
	  raise "Invalid initialization of Vector."
	end
	@c = c
  end
  
  #Accessors
  def point_to(x, y)
    @x = x
	@y = y
  end
  
  def direct_to(angle_t, norm_t)
	@x = Gosu::offset_x(angle_t, norm_t)
    @y = Gosu::offset_y(angle_t, norm_t)    
  end
  
  def angle()
    Gosu::angle(0, 0, @x, @y)
  end
  
  def norm()
    Gosu::distance(0, 0, @x, @y)
  end
  
  def angle=(angle_t)
    direct_to(angle_t, norm)
  end
  
  def norm=(norm_t)
    direct_to(angle, norm_t)
  end
    
  ##Operators
  def +(vector)
    return Vector.new({ :x => @x + vector.x, :y => @y + vector.y})
  end
  
  def -@
    return Vector.new({ :x => -@x, :y => -@y })
  end
  
  def -(vector)
    return self + (-vector)
  end
  
  def *(arg)
    if arg.is_a?(Numeric)
	  return Vector.new({ :x => @x * arg, :y => @y * arg})
    elsif arg.is_a?(Vector)
	  return @x * arg.x + @y * arg.y
	else
	  raise "Invalid argument in vector multiplication"
    end
  end
  
  def /(scalar)
    return self * (1/scalar)
  end
  
  def angle_diff(vector)
    Gosu::angle_diff(@x, @y, vector.x, vector.y)
  end
  
  def distance(vector)
    Gosu::distance(@x, @y, vector.x, vector.y)
  end
  
  def unit_vector()
    return self / norm()
  end
  
  ##Show
  def draw(center)
    if center.is_a?(Vector)
	  Gosu.draw_line(center.x, center.y, c, center.x + @x, center.y + @y, c, 100)
	elsif center.is_a?(Hash)
	  Gosu.draw_line(center[:x], center[:y], c, center[:x] + @x, center[:y] + @y, c, 100)
	else
	  raise "Invalid type of center for vector drawing"
	end
  end
end