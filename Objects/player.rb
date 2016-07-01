class Player
  include DebugDrawable #debug_draw
  include Corporeal #x, y, moves_to, advances, collides?
  include Physical #physics
  include Controllable #key_pressed?
  
  attr_accessor :tag, :body, :velocity, :controller
  def initialize(tag, body, controller)
    @tag = tag
	@body = body
	@velocity = Vector.new(0, 0)
	@controller = controller
  end
  
  def update()
    control()
	friction()
  end
  
  def post_update()
    move()
  end
  
  def control()
    #Internal Control
  end
end