class Text
  attr_accessor :tag, :image, :z
  
  ##Constructor
  def initialize(tag, text, size, z = 0)
    @tag = tag
    @image = Gosu::Image.from_text(text, size)
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
  def draw(x, y, angle = 0)
    @image.draw_rot(x, y, @z, angle)
  end
end