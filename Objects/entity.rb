class Entity
  include DebugDrawable #debug_draw
  include Corporeal #x, y, moves_to, advances, collides?
  include Physical #physics
  
  attr_accessor :tag, :body, :velocity
  
  def initialize(tag, body, velocity = Vector.new(0, 0))
    @tag = tag
	@body = body
	@velocity = velocity
  end
  
  def update(delta = $window.elapsed())
    friction(delta)
	move(delta)
  end
end