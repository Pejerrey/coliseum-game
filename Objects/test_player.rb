class TestPlayer < Player
  include Constants
  
  def control(pool)
    control_update()
	if @status == :neutral
	  #Triggers
	  #attack
	  @status = :attack if a? 
	  #movement
	  f_input = Vector.new(0, 0)
	  f_input.x -= 20 if left? && (!last_input?(right) || !right?)
	  f_input.x += 20 if right? && (!last_input?(left) || !left?)
      f_input.y -= 20 if up? && (!last_input?(down) || !down?)
	  f_input.y += 20 if down? && (!last_input?(up) || !up?)
	  apply_force(f_input)
	  velocity.trim(150)
	  #rotation
	  direction.angle = velocity.angle unless velocity.zero?
	else
	  #Events
	  case @status
	  when :attack then attack(pool)
	  end
	end
  end
  
  
  def attack(pool)
    case @timer.elapsed()
	when -1
	  @timer.start()
	  event_dist = Vector.new(0, 0)
	  event_dist.norm = 50
	  event_dist.angle = direction.angle
	  @event = Rectangle.new(x + event_dist.x, y + event_dist.y, 40, 40)
	  @event.direction.angle = direction.angle
	when 0...600
	  if @event
	    event_dist = Vector.new(0, 0)
		event_dist.norm = 50
		event_dist.angle = direction.angle
	    @event.move_to(x + event_dist.x, y + event_dist.y)
		@event.direction.angle = direction.angle
	    pool.each do |ent|
	      next if ent == self
		  if @event.collides?(ent.body)
		    ent.velocity.x += 300
		    @event = nil
			break
		  end
	    end
	  end
	when 600..INF
      @status = :neutral
	  @timer.stop()
	  @event = nil
	end
  end
end