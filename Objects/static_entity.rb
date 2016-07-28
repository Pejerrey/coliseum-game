class StaticEntity
  include DebugDrawable #debug_draw
  include Corporeal #x, y, moves_to, advances, collides?
  
  attr_accessor :body, :velocity
  def initialize(body)
	@body = body
  end
end