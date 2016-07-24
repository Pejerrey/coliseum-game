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
	when :idling, :guarding
	  if @status == :idling
	    walk()
		@status = :guarding if c?
	  elsif @status == :guarding
	    guard()
		@status = :idling unless c?
	  end
	  @status = :slashing if a?
	  @status = :thrusting if b?
	  
	
	when :slashing then slash(pool)
	when :thrusting then thrust(pool)
	when :hurting then hurt(pool)
	  
	else
	  raise "Unknown status #{@status}"
	end
  end
  
  
  ##Passives
  def walk()
	velocity.apply(movement_direction(2000 * delta))
	velocity.trim(100)
	if target
	  direction.angle = Vector.new(target.x - x, target.y - y).angle
    else
	  unless velocity.zero?
	    direction.angle = velocity.angle
	  end
	end
	if velocity.zero?
	  @image = angled_graphic(:idle)
	else
	  @image = angled_graphic(:walk)
	end
  end
  
  def guard()
    velocity.apply(movement_direction(2000 * delta))
	velocity.trim(70)
	if target
	  direction.angle = Vector.new(target.x - x, target.y - y).angle
    else
	  unless velocity.zero?
	    direction.angle = velocity.angle
	  end
	end
	#@image = angled_graphic(:guard)
  end
  
  
  ##Actions
  def slash(pool)
    regular_attack(15, 2, 15) do |init|
	  if init
	    @event = Event.new(Rectangle.new(0, 0, 40, 25))
	  else
	    @event.in_front_of(self, 25)
		@event.collide(pool-[self]) do |entity|
		  unless entity.status == :guarding
		    entity.apply_force(direction.with_norm(100))
		    entity.status = :hurting
		  end
		  @event = nil
	    end
	  end
	end
  end
  
  def thrust(pool)
    regular_attack(15, 2, 15) do |init|
	  if init
	    @event = Event.new(Rectangle.new(0, 0, 10, 35))
	  else
	    @event.in_front_of(self, 30)
		@event.collide(pool-[self]) do |entity|
		  unless entity.status == :guarding
		    entity.apply_force(direction.with_norm(100))
		    entity.status = :hurting
		  end
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