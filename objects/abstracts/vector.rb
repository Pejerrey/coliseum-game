class Vector
  include Constants
  
  attr_accessor :x, :y
  
  ##Constructor
  def initialize(arg1, arg2, mode = :position)
    case mode
	when :position
	  @x = arg1
	  @y = arg2
	when :polar
	  @x = Gosu::offset_x(arg1, arg2)
	  @y = Gosu::offset_y(arg1, arg2)
	else
	  raise "Invalid hash initialization of Vector"
	end
  end
  
  
  ##Accessors
  def point_to(x, y)
    @x = x
    @y = y
  end
  
  def direct_to(angle, norm)
	@x = Gosu::offset_x(angle, norm)
    @y = Gosu::offset_y(angle, norm)    
  end
  
  def apply(vector)
    @x += vector.x
	@y += vector.y
  end
  
  def angle()
    Gosu::angle(0, 0, @x, @y)
  end
  
  def norm()
    Gosu::distance(0, 0, @x, @y)
  end
  
  def angle=(angle)
    direct_to(angle, norm())
  end
  
  def norm=(norm)
    direct_to(angle(), norm)
  end
  
  def with_angle(angle)
    vect = Vector.new(@x, @y)
	vect.angle = angle
	return vect
  end
  
  def with_norm(norm)
    vect = Vector.new(@x, @y)
	vect.norm = norm
	return vect
  end
  
  def zero?()
    return @x == 0 && @y == 0
  end
  
  

  ##Operators
  def -@
    return Vector.new(-@x, -@y)
  end
  
  def +(vector)
    return Vector.new(@x + vector.x, @y + vector.y)
  end
  
  def -(vector)
    return self + (-vector)
  end
  
  def *(arg)
    if arg.is_a?(Numeric)
	  return Vector.new(@x * arg, @y * arg)
    elsif arg.is_a?(Vector)
	  return @x * arg.x + @y * arg.y
	else
	  raise "Invalid argument in vector multiplication"
    end
  end
  
  def /(scalar)
    return self * (1.0/scalar)
  end
  
  def unit_vector()
    return self / norm()
  end
  
  def reset()
    @x = 0
	@y = 0
  end
  
  def v_copy(vector)
    @x = vector.x
	@y = vector.y
  end
  
  def trim(scalar)
    self.norm = scalar if norm > scalar
  end
  
  
  ##Comparisons
  def angle_diff(vector)
    Gosu::angle_diff(angle, vector.angle)
  end

  def angle_dist(vector)
    angle_diff(vector).abs
  end
  
  def distance(vector)
    Gosu::distance(@x, @y, vector.x, vector.y)
  end
  
  
  ##Loop
  def draw(x, y, c = GREEN)
	Gosu.draw_line(x, y, c, x + @x, y + @y, c, 100)
  end
end