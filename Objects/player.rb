class Player
  include DebugDrawable
  include Corporeal
  include Physical
  include Controllable
  
  #Constructor
  attr_accessor :tag, :body, :velocity, :controller, :status, :event, :timer
  def initialize(tag, body, controller, velocity = Vector.new(0, 0))
    @tag = tag
	@body = body
	@velocity = velocity
	@controller = controller
	@status = :idling
	@event = nil
	@current_frame = 0
	@remaining_frames = 0
	@frame_stop = false
  end
  
  #Loop
  def update(delta = $window.elapsed())
	friction(delta)
	move(delta)
  end
  
  #Auxiliars
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
  
  def delta()
    $window.elapsed()
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
  
  def frame_loop()
    if @frame_stop
	  yield(@current_frame)
	else
	  @remaining_frames = elapsed_frames()
	  while @remaining_frames > 0
	    @remaining_frames -= 1
		@current_frame += 1
		yield(@current_frame)
	  end
	end	
  end
  
  def hold_frame()
    @remaining_frames = 0
    @frame_stop = true
  end
  
  def release_frame()
    @frame_stop = false
  end
  
  def prev_frame()
    @current_frame -= 1
  end
  
  def next_frame()
    @current_frame += 1
  end
  
  def goto(frame) #executes
    @current_frame = frame
  end
  
  def goto_and_play(frame)
    @current_frame = frame - 1
	release_frame()
  end
  
  def goto_and_stop(frame)
    @current_frame = frame
	hold_frame()
  end
  
  def reset_to(symbol)
    @status = symbol
	@current_frame = 0
	@frame_stop = false
  end
  
  def collide(pool)
	pool.each do |entity|
	  next if entity == self
	  if @event.collides?(entity.body)
	    yield(entity)
	  end
	end
  end
end