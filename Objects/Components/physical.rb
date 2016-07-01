module Physical
  #Needs: body, velocity
  include Constants
  
  ##External Behaviour
  def apply_force(vector)
    velocity.x += vector.x
	velocity.y += vector.y
  end
  
  
  private
  ##Internal Behaviour
  def friction()
	unless velocity.zero?
	  prev_angle = velocity.angle
	  velocity.norm -= (FRICTION * delta)
	  velocity.reset if (velocity.angle - prev_angle).abs > EPSILON
    end
  end
  
  def move()
    body.apply(velocity * delta)
  end
  
  
  ##Auxiliars
  def delta()
    $window.elapsed()
  end
end