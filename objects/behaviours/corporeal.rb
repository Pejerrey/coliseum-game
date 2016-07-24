module Corporeal
  include Constants
  
  ##Accessors
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
  
  def c()
    body.c
  end
  
  def c=(c)
    body.c = c
  end
  
  
  ##Transformation
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
  
  def in_front_of(entity, distance)
    body.in_front_of(entity.body, distance)
  end
  
  
  ##Collision
  def holds?(px, py)
    body.holds?(px, py)
  end
  
  def intersects?(segment)
    body.intersects?(segment)
  end
  
  def collides?(entity)
    body.collides?(entity.body)
  end
end