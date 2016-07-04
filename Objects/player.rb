class Player
  include DebugDrawable #debug_draw
  include Corporeal #x, y, moves_to, advances, collides?
  include Physical #physics
  include Controllable #key_pressed?
  
  attr_accessor :tag, :body, :velocity, :controller, :status, :event, :timer
  def initialize(tag, body, controller, velocity = Vector.new(0, 0))
    @tag = tag
	@body = body
	@velocity = velocity
	@controller = controller
	@status = :neutral
	@event = nil
	@timer = Timer.new()
  end
  
  def update(delta = $window.elapsed())
	friction(delta)
	move(delta)
  end
end