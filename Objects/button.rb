class Button
  include DebugDrawable #debug_draw
  include Clickable #activated?
  
  attr_accessor :tag, :body
  def initialize(tag, body)
	@tag = tag
	@body = body
  end
  
  def update()
    check_activation()
  end
end