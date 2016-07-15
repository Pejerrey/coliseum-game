class Player
  include DebugDrawable
  include Corporeal
  include Physical
  include Drawable
  include Controllable
  
  ##Constructor
  attr_accessor :tag, :body, :velocity, :controller, :status, :event, :timer, :image, :current_frame
  def initialize(tag, body, controller, image = nil)
    @tag = tag
	@body = body
	@velocity = Vector.new(0, 0)
	@controller = controller
	@status = :idling
	@event = nil
	@current_frame = 0
	@image = image
  end
  
  
  ##Loop
  def update(delta = $window.elapsed())
	friction(delta)
	move(delta)
  end
  
  
  ##Auxiliars
  private
  def elapsed_frames()
    return case $window.elapsed_ms()
	when 1...24 then 1 #60FPS - 45FPS
	when 24...41 then 2 #45FPS - 25FPS
	when 41...57 then 3 #25FPS - 17FPS
	when 57..66 then 4 #17FPS - 15FPS
	else 0 #idk
	end
  end
  
  def frame_loop()
	elapsed_frames().times do
	  @current_frame += 1
	  yield(current_frame)
	end	
  end
  
  def reset_to(symbol)
    @status = symbol
	@current_frame = 0
  end
  
  def movement_direction(norm = 1)
    force = Vector.new(0, 0)
    force.x -= norm if left? && (!last_input?(right) || !right?)
	force.x += norm if right? && (!last_input?(left) || !left?)
    force.y -= norm if up? && (!last_input?(down) || !down?)
	force.y += norm if down? && (!last_input?(up) || !up?)
	force.trim(norm)
	return force
  end
  
  def delta()
    $window.elapsed()
  end
  
  def graphic(sym)
    obj = @assets.find{ |elem| elem.tag == sym }
	raise "Graphic not found #{sym}" unless obj
	return obj
  end
  
  def angled_graphic(sym)
    case direction.angle
	  when 45...135
	    return graphic(:"#{sym}_right")
	  when 135...225
	    return graphic(:"#{sym}_front")
	  when 225...315
	    return graphic(:"#{sym}_left")
	  when 315..360, 0...45
	    return graphic(:"#{sym}_back")
	  end
	end
end