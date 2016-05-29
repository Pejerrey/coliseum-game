class Point
  include Constants
  
  CROSSHAIR_LENGTH = 2
  
  attr_accessor :x, :y, :c
  def initialize(x, y, c = GREEN)
    @x = x
	@y = y
	@c = c
  end
  
  def draw()
	Gosu.draw_triangle(@x, @y - CROSSHAIR_LENGTH, @c,
	                   @x - CROSSHAIR_LENGTH, @y + CROSSHAIR_LENGTH, @c,
					   @x + CROSSHAIR_LENGTH, @y + CROSSHAIR_LENGTH, @c)
  end
end