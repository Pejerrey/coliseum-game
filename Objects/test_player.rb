class TestPlayer < Player
  include Constants
  include AssetsManager
  
  def initialize(tag, body, controller, z = nil)
    super(tag, body, controller, z)
	load_assets()
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
	  @status = :slashing if a?
	  @status = :thrusting if b?
	  @status = :stepping_in if c? && arrow?
	
	when :stepping_in then step_in(pool)
	when :stepping_out then step_out(pool)
	
	when :slashing then slash(pool)
	when :thrusting then thrust(pool)
	when :hurting then hurt(pool)
	  
	else
	  raise "Unknown status #{@status}"
	end
	
  end
  
  
  ##Passives
  def walk()
	velocity.apply(movement_direction(1500 * delta))
	velocity.trim(80)
	unless velocity.zero?
	  if target
		direction.angle = Vector.new(target.x - x, target.y - y).angle
      else
	    direction.angle = velocity.angle
	  end
	end
	if velocity.zero?
	  @image = angled_graphic(:idle)
	else
	  @image = angled_graphic(:walk)
	end
  end
  
  def run()
	velocity.apply(movement_direction(1500 * delta))
	velocity.trim(160)
	direction.angle = velocity.angle unless velocity.zero?
	@image = angled_graphic(:run)
  end
  
  
  ##States
  def step_in(pool)
    frame_loop() do |frame|
	  case frame
	  when 1
	    velocity.reset()
		if movement_direction.zero?
		  @f_step = direction.dup.with_norm(200)
		else
		  @f_step = movement_direction(200)
		end
		apply_force(@f_step)
	  when 8
	    velocity.reset()
	  when 9...INF
	    unless arrow? && c?
		  reset_to(:stepping_out)
		  return
		end
	  end
	end
  end
	
  def step_out(pool)
    frame_loop() do |frame|
	  case frame
	  when 1
	    velocity.reset()
	    apply_force(-@f_step)
	  when 8
	    velocity.reset()
	  when 9...INF
	    unless c?
	      reset_to(:idling)
		  return
		end
	    if arrow?
		  reset_to(:stepping_in)
		  return
		end
	  end
	end
  end
  
  
  ##Actions
  def slash(pool)
    regular_attack(9, 6, 6) do |init|
	  if init
	    @event = Event.new(Rectangle.new(0, 0, 40, 25))
	  else
	    @event.in_front_of(self, 25)
		@event.collide(pool-[self]) do |entity|
		  entity.apply_force(direction.with_norm(100))
		  entity.status = :hurting
		  @event = nil
	    end
	  end
	end
  end
  
  def thrust(pool)
    regular_attack(9, 6, 6) do |init|
	  if init
	    @event = Event.new(Rectangle.new(0, 0, 25, 30))
	  else
	    @event.in_front_of(self, 30)
		@event.collide(pool-[self]) do |entity|
		  entity.apply_force(direction.with_norm(100))
		  entity.status = :hurting
		  @event = nil
	    end
	  end
	end
  end
  
  def hurt(pool)
    frame_loop do |frame|
	  if frame == 12
	    @status = :idling
		@current_frame = 0
		return
	  end
	end
  end
  	
end