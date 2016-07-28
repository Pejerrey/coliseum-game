class Still
  attr_accessor :image, :z, :x_scale, :y_scale
  
  ##Constructor
  def initialize(filename, z = 0, x_scale = 1, y_scale = 1)
    @image = Gosu::Image.new("media/" + filename)
	@z = z
	@x_scale = x_scale
	@y_scale = y_scale
  end
  
  ##Accessors
  def width() 
    return @image.width
  end
  
  def height()
    return @image.height
  end
  
  ##Loop
  def draw(x, y, z = @z, angle = 0, x_scale = @x_scale, y_scale = @y_scale)
	@image.draw_rot(x, y, z, angle,
	                0.5, 0.5, x_scale, y_scale)
  end
end