class Body
  attr_accessor :tag, :mass, :shape
  
  ##Contructor
  def initialize(tag, mass, shape)
    @tag = tag
	@mass = mass
	@shape = shape
  end
  
  ##Accessors  
  def x() @shape.x end
  def y() @shape.y end
  def x=(x) @shape.x = x end
  def y=(y) @shape.y = y end
  def left() @shape.left() end
  def right() @shape.right() end
  def top() @shape.top() end
  def bottom() @shape.bottom() end
  def left=(left) @shape.left = left end
  def right=(right) @shape.right = right end
  def top=(top) @shape.top = top end
  def bottom=(bottom) @shape.bottom = bottom end
  def bounds() @shape end
  
  ##Loop
  def update()
  end
  
  def draw()
    @shape.draw()
  end
  
  ##Collision
  def holds?(point)
    @shape.holds?(point)
  end
  
  def intersects?(segment)
    @shape.intersects?(segment)
  end
  
  def collides?(body)
    @shape.collides?(body.shape)
  end
end