class TestPlayer < Player
  include Constants
  
  ##Main
  def control(pool)
    control_update()
	case @status
	when :idling then neutral(pool)
	when :running then run(pool)
	when :attacking then attack(pool)
	when :stepping then step(pool)
	else
	  raise "Unknown status #{@status}"
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
	f_move = Vector.new(0, 0)
	f_move.x -= 20 if left? && (!last_input?(right) || !right?)
	f_move.x += 20 if right? && (!last_input?(left) || !left?)
    f_move.y -= 20 if up? && (!last_input?(down) || !down?)
	f_move.y += 20 if down? && (!last_input?(up) || !up?)
	f_move.trim(20)
	velocity.apply(f_move)
	velocity.trim(100)
	direction.angle = velocity.angle unless velocity.zero?
  end
  
  def run(pool)
    #triggers
	@status = :idling if !right? && !left? && !down? && !up?
  	#movement
	f_move = Vector.new(0, 0)
	f_move.x -= 30 if left? && (!last_input?(right) || !right?)
	f_move.x += 30 if right? && (!last_input?(left) || !left?)
    f_move.y -= 30 if up? && (!last_input?(down) || !down?)
	f_move.y += 30 if down? && (!last_input?(up) || !up?)
	f_move.trim(30)
	velocity.apply(f_move)
	velocity.trim(200)
	direction.angle = velocity.angle unless velocity.zero?
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
      @status = :idling
	  @timer.stop()
	  @event = nil
	end
  end
  
  def step(pool)
	#init
    if @timer.elapsed == -1
	  @timer.start()
	  @anchor_x = x
	  @anchor_y = y
	else
	  #triggers
	  unless c?
	    @status = :idling 
	    @timer.stop()
	  end
	  #step
	  f_move = Vector.new(0, 0)
	  f_move.x -= 30 if left? && (!last_input?(right) || !right?)
	  f_move.x += 30 if right? && (!last_input?(left) || !left?)
      f_move.y -= 30 if up? && (!last_input?(down) || !down?)
	  f_move.y += 30 if down? && (!last_input?(up) || !up?)
	  f_move.trim(30)
	  self.x = @anchor_x + f_move.x
	  self.y = @anchor_y + f_move.y
	end
  end
end