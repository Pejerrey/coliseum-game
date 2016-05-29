class Rectangle
  include Constants
  
  attr_accessor :x, :y, :width, :height, :color
  def initialize(x, y, width, height, color = RED)
    @x = x
	@y = y
	@width = width
	@height = height
	@color = color
  end
  
  def draw()
    Utils.draw_rect(self)
  end
  
  def left() @x - @width/2 end
  def right() @x + @width/2 end
  def top() @y - @height/2 end
  def bottom() @y + @height/2 end
  def left=(left) @x = left + @width/2 end
  def right=(right) @x = right - @width/2 end
  def top=(top) @y = top + @height/2 end
  def bottom=(bottom) @y = bottom - @height/2 end
end