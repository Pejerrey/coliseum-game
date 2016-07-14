class Still
  attr_accessor :image, :z
  
  ##Constructor
  def initialize(filename, z = 0)
    @image = Gosu::Image.new("media/" + filename)
	@z = z
  end
  
  ##Accessors
  def width() 
    return @image.width
  end
  
  def height()
    return @image.height
  end
  
  ##Loop
  def draw(x, y)
    @image.draw(x - width/2, y - height/2, @z)
  end
end