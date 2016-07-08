class Rectangle < Polygon
  include Constants

  def initialize(x, y, width, height, c = RED)
    @x = x
	@y = y
	@direction = Vector.new(0, -1)
    @zero_vertex = []
	@zero_vertex << { :x => width/2, :y => height/2}
	@zero_vertex << { :x => -width/2, :y => height/2}
	@zero_vertex << { :x => -width/2, :y => -height/2}
	@zero_vertex << { :x => width/2, :y => -height/2}
	@c = c
  end
end