class Entity
  ##Initialization
  attr_accessor :body, :mass, :image
  attr_accessor :pos, :angle, :speed
  def initialize(body, image, mass, pos, angle)
	@body = body
	@mass = mass
	@image = image
	@pos = Point.new(x, y)
	@angle = angle
	@speed = Vector.new(point: [0, 0])
  end
  
  ##Public Methods
  def travel()
	@x += (@speed.x * Pacemaker.elapsed).round
    @y += (@speed.y * Pacemaker.elapsed).round
  end
    
  def draw()
    @image.draw()
	@body.draw()
  end
end