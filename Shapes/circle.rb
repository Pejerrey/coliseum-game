class Circle
  include Constants
  
  attr_accessor :x, :y, :radius, :color
  def initialize(x, y, radius, color = YELLOW)
    @x = x
	@y = y
	@radius = radius
	@color = color
  end
  
  def draw()
    Utils.draw_circ(self)
  end
  
  def left() @x - @radius/2 end
  def right() @x + @radius/2 end
  def top() @y - @radius/2 end
  def bottom() @y + @radius/2 end
  def left=(left) @x = left + @radius/2 end
  def right=(right) @x = right - @radius/2 end
  def top=(top) @y = top + @radius/2 end
  def bottom=(bottom) @y = bottom - @radius/2 end
end