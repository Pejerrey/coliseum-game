class Circle
  include Shape
  include Constants
  
  #Initialization
  attr_accessor :x, :y, :radius, :color
  def initialize(x, y, radius, color = YELLOW)
    @x = x
	@y = y
	@radius = radius
	@color = color
  end
  
  #Collision
  def holds?(px, py)
    return distance(px, py, @x, @y) <= @radius
  end
  
  def collides_with?(shape)
    if shape.is_a?(Circle)
	  circle = shape
	  return distance(@x, @y, shape.x, shape.y) <= @radius + circle.radius
	elsif shape.is_a?(Rectangle)
	  rectangle = shape
	  
	else
	  raise "Shape not recognized for collision with circle"
	end
  end
  
  #Indirect Attributes
  def width() @radius * 2 end
  def height() @radius * 2 end
  def left() @x - @radius/2 end
  def right() @x + @radius/2 end
  def top() @y - @radius/2 end
  def bottom() @y + @radius/2 end
  def left=(left) @x = left + @radius/2 end
  def right=(right) @x = right - @radius/2 end
  def top=(top) @y = top + @radius/2 end
  def bottom=(bottom) @y = bottom - @radius/2 end
  
  #Draw
  def draw()
    Utils.draw_circ(self) if $DEBUG_MODE
  end
end