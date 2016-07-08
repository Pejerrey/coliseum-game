class Rectangle < Polygon
  include Constants

  def initialize(x, y, width, height, c = RED)
    super(x, y, [Vector.new(width/2, height/2),
                 Vector.new(-width/2, height/2),
                 Vector.new(-width/2, -height/2),
                 Vector.new(width/2, -height/2)], c)
  end
end