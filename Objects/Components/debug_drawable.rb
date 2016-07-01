module DebugDrawable
  #Needs body
  def debug_draw()
    body.draw()
    if self.class.included_modules.include?(Physical)
	  (velocity/2).draw(body.x, body.y) 
	end
  end
end