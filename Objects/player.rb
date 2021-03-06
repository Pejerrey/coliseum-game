class Player
  include DebugDrawable
  include Corporeal
  include Physical
  include Drawable
  include Controllable
  
  ##Constructor
  attr_accessor :body, :velocity, :controller, :status, :hitbox, :timer, :image, :current_frame, :target, :assets, :info
  def initialize(body, controller, info = 0)
	@body = body
	@velocity = Vector.new(0, 0)
	@controller = controller
	@status = :idling
	@hitbox = nil
	@current_frame = 0
	@image = nil
	@target = nil
	@assets = Hash.new()
	@info = info #0 - no info, 1 - player1, 2 -player2
  end
  
  
  ##Loop
  def update(delta = $window.elapsed())
	friction(delta)
	move(delta)
  end
  
  def draw()
    @image.draw(x, y, y, angle = 0)
  end
  
  def debug_draw()
    body.draw()
	(velocity/2).draw(body.x, body.y)
	(body.direction*20).draw(body.x, body.y, FUCHSIA)
	@hitbox.debug_draw() if @hitbox
	case status
	when :idling, :running
	  body.c = YELLOW
	when :slashing, :thrusting, :knocking
	  body.c = GREEN
	when :tumbling
	  body.c = FUCHSIA
	when :hurting
	  body.c = RED
	when :guarding, :blocking
	  body.c = GRAY
	end
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
    obj = assets[sym]
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
  
  def regular_event(startup, active, recovery)
    frame_loop do |frame|
	  case frame
	  when (startup + 1)..(startup + active) #active
	    yield(true)	if frame == startup + 1
	    yield(false) if @hitbox
	  
	  when (startup + active + recovery + 1) #exit
	    @hitbox = nil
	    reset_to(:idling)
		return
	  
	  when (startup + active + 1)
	    @hitbox = nil #doesn't really do much, for debug purposes.
	  end
	end
  end
  
  def wait(size)
    frame_loop do |frame|
	  if frame == size
	    @status = :idling
		@current_frame = 0
		return
	  end
	end
  end
end