class Still
  attr_accessor :tag, :image, :z
  attr_accessor :x_scale, :y_scale
  
  ##Constructor
  def initialize(tag, filename, z = 0, x_scale = 1, y_scale = 1)
    @tag = tag
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
  def draw(x, y, angle = 0)
	@image.draw_rot(x, y, @z,
	                angle, 0.5, 0.5,
					@x_scale, @y_scale)
  end
end