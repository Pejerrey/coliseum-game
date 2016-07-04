module DebugDrawable
  #Needs body
  def debug_draw()
    body.draw()
    if self.class.included_modules.include?(Physical)
	  (velocity/2).draw(body.x, body.y) 
	end
	if self.is_a?(Player) && self.event
	  self.event.draw()
	end
  end
end