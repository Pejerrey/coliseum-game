class Still
  attr_accessor :tag, :image, :z, :flipped
  
  ##Constructor
  def initialize(tag, filename, z = 0, flipped = false)
    @tag = tag
    @image = Gosu::Image.new("media/" + filename)
	@z = z
	@flipped = flipped
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
    if @flipped
	  @image.draw(x + width/2, y - height/2, @z, -1)
	else
      @image.draw(x - width/2, y - height/2, @z)
	end
  end
end