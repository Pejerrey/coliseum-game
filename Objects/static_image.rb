class StaticImage
  attr_accessor :tag, :image, :x, :y, :z
  
  ##Constructor
  def initialize(tag, image, x, y, z = 0)
    @tag = tag
    @image = image
	@x = x 
	@y = y 
	@z = z
  end
  
  ##Accessors
  def width() 
    return @image.width
  end
  
  def height()
    return @image.height
  end
  
  def bounds()
    return Rectangle.new(@x, @y, width, height)
  end
  
  ##Loop
  def draw()
    @image.draw(@x - width/2, @y - height/2, @z)
  end
end