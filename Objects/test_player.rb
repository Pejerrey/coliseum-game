class TestPlayer < Player
  include Constants
  
  ##Image storage
  IDLE_FRONT ||= Still.new(:idle_front, "test/test_idle_front.bmp")
  IDLE_LEFT ||= Still.new(:idle_left, "test/test_idle_side.bmp", 0, true)
  IDLE_RIGHT ||= Still.new(:idle_right, "test/test_idle_side.bmp")
  IDLE_BACK ||= Still.new(:idle_back, "test/test_idle_back.bmp")
  WALK_FRONT ||= Still.new(:walk_front, "test/test_walk_front.bmp")
  WALK_LEFT ||= Still.new(:walk_left, "test/test_walk_side.bmp", 0, true)
  WALK_RIGHT ||= Still.new(:walk_right, "test/test_walk_side.bmp")
  WALK_BACK ||= Still.new(:walk_back, "test/test_walk_back.bmp")
  RUN_FRONT ||= Still.new(:run_front, "test/test_run_front.bmp")
  RUN_LEFT ||= Still.new(:run_left, "test/test_run_side.bmp", 0, true)
  RUN_RIGHT ||= Still.new(:run_right, "test/test_run_side.bmp")
  RUN_BACK ||= Still.new(:run_back, "test/test_run_back.bmp")
  THRUST_FRONT ||= Still.new(:thrust_front, "test/test_thrust_front.bmp")
  THRUST_LEFT ||= Still.new(:thrust_left, "test/test_thrust_side.bmp", 0, true)
  THRUST_RIGHT ||= Still.new(:thrust_right, "test/test_thrust_side.bmp")
  THRUST_BACK ||= Still.new(:thrust_back, "test/test_thrust_back.bmp")
  
  
  ##Main
  def control(pool)
    control_update()
	
	case @status
	when :idling, :running
	  if @status == :idling
	    walk()
	  	if combo?(:left, 200, :left) || combo?(:right, 200, :right) ||
		   combo?(:up, 200, :up) || combo?(:down, 200, :down)
		  @status = :running 
		end
	  else
	    run()
		if !right? && !left? && !down? && !up?
		  @status = :idling 
		end
	  end
	  @status = :attacking if a?
	  
	when :attacking
	  attack(pool)
	  
	else
	  raise "Unknown status #{@status}"
	end
	
  end
  
  
  ##States
  def walk()
	velocity.apply(movement_direction(1500 * delta))
	velocity.trim(80)
	direction.angle = velocity.angle unless velocity.zero?
	#image
	if velocity.zero?
	  case direction.angle
	  when 45...135
	    @image = IDLE_RIGHT #Turned
	  when 135...225
	    @image = IDLE_FRONT
	  when 225...315
	    @image = IDLE_LEFT
	  when 315..360, 0...45
	    @image = IDLE_BACK
	  end
	else
	  case direction.angle
	  when 45...135
	    @image = WALK_RIGHT #Turned
	  when 135...225
	    @image = WALK_FRONT
	  when 225...315
	    @image = WALK_LEFT
	  when 315..360, 0...45
	    @image = WALK_BACK
	  end
	end
  end
  
  def run()
	velocity.apply(movement_direction(1200 * delta))
	velocity.trim(175)
	direction.angle = velocity.angle unless velocity.zero?
	#image
	case direction.angle
	when 45...135
	  @image = RUN_RIGHT #Turned
	when 135...225
	@image = RUN_FRONT
	when 225...315
	  @image = RUN_LEFT
	when 315..360, 0...45
	  @image = RUN_BACK
	end
  end
  
  # def step(pool)
	# frame_loop() do |frame|
	  # case frame
	  # when 1
	    # velocity.reset()
		
	  # when 2..3
	    # #trigger
	    # unless c?
		  # reset_to(:idling)
		  # return
		# end
		# #hold
		# hold_frame()
	    # case frame
		# when 2
		  # if arrow?
		    # @step_f = movement_direction(200)
		    # apply_force(@step_f)
		    # goto_and_play(10)
		  # end
		# when 3
		   # if !arrow?
		     # apply_force(-@step_f)
			 # goto_and_play(20)
		   # end
		# end
	  
	  # when 11..17
	  # when 18
	    # velocity.reset()
	    # goto_and_stop(3)
	  # when 21..27
	  # when 28
	    # velocity.reset()
	    # goto_and_stop(2)
	  # end
	# end
  # end
  
  
  ##Events
  def attack(pool)
    frame_loop do |frame|
	  case frame
	  when 1..2 #start-up
	  when 3..16 #active
	    if frame == 3
		  @event = Event.new(Rectangle.new(0, 0, 40, 40))
		  @event.in_front_of(self, 50)
		elsif frame < 16 && @event
		  @event.in_front_of(self, 50)
		  @event.collide(pool-[self]) do |entity|
		    entity.apply_force(direction.with_norm(100))
			@event = nil
		  end
		elsif frame == 16
		  @event = nil
		end
	  when 17..19 #recovery
	  when 20 #exit
	    reset_to(:idling)
		return
	  end
	end
  end
		
end