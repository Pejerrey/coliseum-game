class StaticEntity
  include DebugDrawable #debug_draw
  include Corporeal #x, y, moves_to, advances, collides?
  
  attr_accessor :tag, :body, :velocity
  def initialize(tag, body)
    @tag = tag
	@body = body
  end
end