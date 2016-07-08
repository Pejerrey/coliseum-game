module DebugDrawable
  include Constants
  
  ##Loop
  def debug_draw()
    #body
    body.draw()
	#direction
	(body.direction*20).draw(body.x, body.y, FUCHSIA)
	#velocity
    if self.class.included_modules.include?(Physical)
	  (velocity/2).draw(body.x, body.y) 
	end
	#events
	event.draw() if self.is_a?(Player) && @event
  end
end