class Vector
  include Constants
  attr_accessor :x, :y
  
  ##Constructor
  def initialize(*args)
    if args.size == 1
	  hsh = args[0]
      if hsh[:x] && hsh[:y]
	    @x = hsh[:x]
	    @y = hsh[:y]
	  elsif hsh[:angle] && hsh[:norm]
	    @x = Gosu::offset_x(hsh[:angle], hsh[:norm])
	    @y = Gosu::offset_y(hsh[:angle], hsh[:norm])
	  else
	    raise "Invalid hash initialization of Vector"
	  end
	elsif args.size() == 2
	  @x, @y = *args
	  unless @x && @y && @x.is_a?(Numeric) && @y.is_a?(Numeric)
	    raise "Invalid direct initialization of Vector." 
	  end
	else
	  raise "Unknown type to initialization of Vector"
	end
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
    return (self * (1.0/scalar))
  end
  
  def angle_diff(vector)
    Gosu::angle_diff(angle, vector.angle)
  end

  def angle_dist(vector)
    angle_diff(vector).abs
  end
  
  def distance(vector)
    Gosu::distance(@x, @y, vector.x, vector.y)
  end
  
  def unit_vector()
    return self / norm()
  end
  
  def reset()
    @x = 0
	@y = 0
  end
  
  def zero?()
    return @x == 0 && @y == 0
  end
  
  def copy(vector)
    @x = vector.x
	@y = vector.y
  end
  
  def trim(scalar)
    self.norm = scalar if norm > scalar
  end
  
  
  ##SHOW
  def draw(x, y, c = GREEN)
	Gosu.draw_line(x, y, c, x + @x, y + @y, c, 100)
  end
end