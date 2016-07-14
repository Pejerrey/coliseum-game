class TestPlayer < Player
  include Constants
  
  ##Image storage
  IDLE_FRONT ||= Still.new("test/test_idle_front.bmp")
  IDLE_LEFT ||= Still.new("test/test_idle_side.bmp")
  IDLE_RIGHT ||= FlippedStill.new("test/test_idle_side.bmp")
  IDLE_BACK ||= Still.new("test/test_idle_back.bmp")
  
  
  ##Main
  def control(pool)
    control_update()
	case @status
	when :idling then neutral(pool)
	when :running then run(pool)
	when :attacking then attack(pool)
	when :stepping then step(pool)
	else raise "Unknown status #{@status}"
	end
  end
  
  
  ##States
  def neutral(pool)
	#triggers
	@status = :stepping if c?
	@status = :attacking if a?
	@status = :running if combo?(:left, 200, :left) ||
	                      combo?(:right, 200, :right) ||
						  combo?(:up, 200, :up) ||
						  combo?(:down, 200, :down)
	#movement
	velocity.apply(movement_direction(1500 * delta))
	velocity.trim(80)
	direction.angle = velocity.angle unless velocity.zero?
	#image

  end
  
  def run(pool)
    #triggers
	@status = :stepping if c?
	@status = :idling if !right? && !left? && !down? && !up?
  	#movement
	velocity.apply(movement_direction(1200 * delta))
	velocity.trim(175)
	direction.angle = velocity.angle unless velocity.zero?
  end
  
  def attack(pool)
    frame_loop do |frame|
	  case frame
	  when 1..2 #start-up
	  when 3 #active_in
	    event_dist = direction.with_norm(50)
	    @event = Rectangle.new(x + event_dist.x, y + event_dist.y, 40, 40)
	    @event.direction.angle = direction.angle
	  when 4..15 #active
	    if @event
	      event_dist = direction.with_norm(50)
	      @event.move_to(x + event_dist.x, y + event_dist.y)
		  @event.rotate_to(direction.angle)
		  collide(pool) do |entity|
		    entity.apply_force(direction.with_norm(100))
			@event = nil
			break
		  end
		end
	  when 16 #active_out
	    @event = nil
	  when 17..19 #recovery
	  when 20 #exit
	    reset_to(:idling)
		return
	  end
	end
  end
  
  def step(pool)
	frame_loop() do |frame|
	  case frame
	  when 1
	    velocity.reset()
		
	  when 2..3
	    #trigger
	    unless c?
		  reset_to(:idling)
		  return
		end
		#hold
		hold_frame()
	    case frame
		when 2
		  if arrow?
		    @step_f = movement_direction(200)
		    apply_force(@step_f)
		    goto_and_play(10)
		  end
		when 3
		   if !arrow?
		     apply_force(-@step_f)
			 goto_and_play(20)
		   end
		end
	  
	  when 11..17
	  when 18
	    velocity.reset()
	    goto_and_stop(3)
	  when 21..27
	  when 28
	    velocity.reset()
	    goto_and_stop(2)
	  end
	end
  end
		
end