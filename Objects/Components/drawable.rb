module Drawable
  #Needs: body, image

  ##Public Behaviour
  def draw()
    image.draw(body.x, body.y)
  end
  
  def i_width() 
    return image.width()
  end
  
  def i_height()
    return image.height()
  end
  
  def i_bounds(x, y)
    return Rectangle.new(x, y, i_width, i_height)
  end
end