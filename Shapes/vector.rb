class Vector
  include Constants
  
  #Initialization
  attr_accessor :x, :y, :c
  def initialize(init, c = GREEN)
    if init[:point]
	  @x, @y = init[:point]
	elsif init[:polar]
	  angle, norm = init[:polar]
	  @x = Gosu::offset_x(angle, norm)
	  @y = Gosu::offset_y(angle, norm)
	else
	  raise "Invalid initialization of Vector."
	end
	@c = c
  end
  
  
  #Coordinate Transformation
  def point_to(x, y)
    @x = x
	@y = y
  end
  
  #Polar Transformation
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
  
  def direct_to(angle_t, norm_t)
	@x = Gosu::offset_x(angle_t, norm_t)
    @y = Gosu::offset_y(angle_t, norm_t)    
  end
  
  
  #Draw Functions
  def draw(center)
	#Gosu.draw_line()
  end
end