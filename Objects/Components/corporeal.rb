module Corporeal
  include Constants
  
  #Accessors
  def x()
    body.x
  end
  
  def x=(x)
    body.x = x
  end
  
  def y()
    body.y
  end
  
  def y=(y)
    body.y = y
  end
  
  def direction()
    body.direction
  end
  
  def direction=(dir)
    body.direction = dir.dup()
  end
  
  #Transformation
  def move_to(x, y)
    body.move_to(x, y)
  end
    
  def rotate_to(angle)
    body.rotate_to(angle)
  end
  
  def advance(x, y)
    body.advance(x, y)
  end
  
  def turn(angle)
    body.turn(angle)
  end
  
  def apply(vector)
    body.apply(vector)
  end
  
  def scale(scalar)
    body.scale(scalar)
  end
  
  #Collision
  def holds?(point)
    body.holds?(point)
  end
  
  def intersects?(segment)
    body.intersects?(segment)
  end
  
  def collides?(entity)
    body.collides?(entity.body)
  end
end