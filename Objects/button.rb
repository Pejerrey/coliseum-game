class Button
  include DebugDrawable #debug_draw
  include Clickable #activated?
  
  attr_accessor :body
  def initialize(body)
	@body = body
  end
  
  def update()
    check_activation()
  end
end