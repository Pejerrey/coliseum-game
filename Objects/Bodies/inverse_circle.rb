class InverseCircle < Circle
  ##COLLISION
  def holds?(point)
    return !super(point)
  end
  
  def intersects?(seg)
    return !super(seg)
  end
  
  def collides?(body)
    if body.is_a?(InverseCircle)
	  inverse_circle = body
	  return true
    elsif body.is_a?(Circle)
	  circle = body
	  return Gosu::distance(x, y, circle.x, circle.y) + [@radius, circle.radius].min >
	         [@radius, circle.radius].max
	elsif body.is_a?(Polygon)
	  polygon = body
	  return polygon.segments.any? { |seg| intersects?(seg) }
	else
	  raise "Body not recognized for collision with circle"
	end
  end
end