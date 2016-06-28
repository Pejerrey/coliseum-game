class Rectangle < Polygon
  include Constants

  def initialize(x, y, width, height)
    @x = x
	@y = y
    @zero_vertex = []
	@zero_vertex << { :x => width/2, :y => height/2}
	@zero_vertex << { :x => -width/2, :y => height/2}
	@zero_vertex << { :x => -width/2, :y => -height/2}
	@zero_vertex << { :x => width/2, :y => -height/2}
  end
end