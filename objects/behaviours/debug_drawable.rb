module DebugDrawable
  include Constants
  
  ##Loop
  def debug_draw()
    #body
    body.draw()
    #velocity
    if self.class.included_modules.include?(Physical)
	  (velocity/2).draw(body.x, body.y) 
	end
	#direction
	(body.direction*20).draw(body.x, body.y, FUCHSIA)
	#events
	event.draw() if self.is_a?(Player) && @event
  end
end