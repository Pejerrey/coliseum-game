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
  def draw(x, y)
    @image.draw(x - width/2, y - height/2, @z)
  end
end