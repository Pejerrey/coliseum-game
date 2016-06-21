class Rectangle < Polygon
  include Constants

  def initialize(x, y, width, height)
    @vertex = []
	@vertex << { :x => x + width/2, :y => y + height/2}
	@vertex << { :x => x - width/2, :y => y + height/2}
	@vertex	<< { :x => x - width/2, :y => y - height/2}
	@vertex	<< { :x => x + width/2, :y => y - height/2}
  end
end