class Entity
  include DebugDrawable #debug_draw
  include Corporeal #x, y, moves_to, advances, collides?
  include Physical #physics
  
  attr_accessor :tag, :body, :velocity
  def initialize(tag, body)
    @tag = tag
	@body = body
	@velocity = Vector.new(0, 0)
  end
  
  def update()
    friction()
  end
  
  def post_update()
    move()
  end
end