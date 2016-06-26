class Rectangle < Polygon
  include Constants

  def initialize(x, y, width, height)
    @x = x
	@y = y
    @vertex = []
	@vertex << { :x => width/2, :y => height/2}
	@vertex << { :x => -width/2, :y => height/2}
	@vertex	<< { :x => -width/2, :y => -height/2}
	@vertex	<< { :x => width/2, :y => -height/2}
  end
end