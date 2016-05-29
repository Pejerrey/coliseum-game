class StaticImage
  attr_accessor :tag, :image, :x, :y, :z
  
  def initialize(tag, image, x, y, z = 0)
    @tag = tag
    @image = image
	@x = x >= 0 ? x : $window.width + x 
	@y = y >= 0 ? y : $window.height + y 
	@z = z
  end
  
  def draw()
    @image.draw(@x - width/2, @y - height/2, @z)
  end
  
  def width() 
    return @image.width
  end
  
  def height()
    return @image.height
  end
  
  def bounds()
    return Rectangle.new(@x, @y, width, height)
  end
end