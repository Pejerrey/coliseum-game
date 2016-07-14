module Drawable
  #Accessors
  def i_width() 
    return image.width()
  end
  
  def i_height()
    return image.height()
  end
  
  def i_bounds(x, y)
    return Rectangle.new(x, y, i_width, i_height)
  end

  #Loop
  def draw()
    image.draw(body.x, body.y) if image
  end
end