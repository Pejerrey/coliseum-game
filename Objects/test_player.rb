class TestPlayer < Player
  include Constants
  
  SCALE = 1.6
  
  def initialize(tag, body, controller, image = nil)
    super(tag, body, controller, image)
	@assets =
		[Still.new(:idle_front, "test/test_idle_front.bmp", 0, SCALE, SCALE) ,
		Still.new(:idle_left, "test/test_idle_side.bmp", 0, -SCALE, SCALE) ,
		Still.new(:idle_right, "test/test_idle_side.bmp", 0, SCALE, SCALE) ,
		Still.new(:idle_back, "test/test_idle_back.bmp", 0, SCALE, SCALE) ,
		
		Loop.new(:walk_front, ["test/test_idle_front.bmp", 400,
		                       "test/test_walk1_front.bmp", 400,
							   "test/test_idle_front.bmp", 400,
							   "test/test_walk2_front.bmp", 400], 0, SCALE, SCALE) ,
		Loop.new(:walk_left, ["test/test_idle_side.bmp", 400,
		                       "test/test_walk1_side.bmp", 400,
							   "test/test_idle_side.bmp", 400,
							   "test/test_walk2_side.bmp", 400], 0, -SCALE, SCALE) ,
		Loop.new(:walk_right, ["test/test_idle_side.bmp", 400,
		                       "test/test_walk1_side.bmp", 400,
							   "test/test_idle_side.bmp", 400,
							   "test/test_walk2_side.bmp", 400], 0, SCALE, SCALE) ,
		Loop.new(:walk_back, ["test/test_idle_back.bmp", 400,
		                      "test/test_walk1_back.bmp", 400,
							  "test/test_idle_back.bmp", 400,
							  "test/test_walk2_back.bmp", 400], 0, SCALE, SCALE) ,
		
		Still.new(:run_front, "test/test_run_front.bmp") ,
		Still.new(:run_left, "test/test_run_side.bmp", 0, -1) ,
		Still.new(:run_right, "test/test_run_side.bmp") ,
		Still.new(:run_back, "test/test_run_back.bmp") ,
		
		Still.new(:thrust_front, "test/test_thrust_front.bmp") ,
		Still.new(:thrust_left, "test/test_thrust_side.bmp", 0, -1) ,
		Still.new(:thrust_right, "test/test_thrust_side.bmp") ,
		Still.new(:thrust_back, "test/test_thrust_back.bmp")]
  end
  
  
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
	if velocity.zero?
	  @image = angled_graphic(:idle)
	else
	  @image = angled_graphic(:walk)
	end
  end
  
  def run()
	velocity.apply(movement_direction(1200 * delta))
	velocity.trim(175)
	direction.angle = velocity.angle unless velocity.zero?
	@image = angled_graphic(:run)
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