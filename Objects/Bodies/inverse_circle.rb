class InverseCircle < Circle
  ##Collision
  def holds?(px, py)
    return !super(px, py)
  end
  
  def intersects?(segment)
    return !super(segment)
  end
  
  def collides?(body)
    if body.is_a?(InverseCircle)
	  inverse_circle = body
	  return true
    elsif body.is_a?(Circle)
	  circle = body
	  return Gosu::distance(@x, @y, circle.x, circle.y) >
	         [@radius, circle.radius].max - [@radius, circle.radius].min
	elsif body.is_a?(Polygon)
	  polygon = body
	  return polygon.segments.any? { |segment| intersects?(segment) }
	else
	  raise "Body not recognized for collision with circle"
	end
  end
end