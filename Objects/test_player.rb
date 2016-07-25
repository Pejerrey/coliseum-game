class TestPlayer < Player
  include Constants
  include AssetsManager
  
  attr_accessor :shield_life, :shield_endurance
  
  def initialize(tag, body, controller, z = nil)
    super(tag, body, controller, z)
	load_assets()
	@shield_endurance = 50
	@shield_life = @shield_endurance
  end
  
  
  ##Loop
  def draw()
    super()
	if shield_life > 0
	  if tag == :p_1
	    GREY_BAR.draw_rot(50, 50, 0, 0,
		                  0, 0.5,  @shield_life, 1)
	  elsif tag == :p_2
	    GREY_BAR.draw_rot($window.width - 50, $window.height - 50, 0, 0,
		                  1, 0.5,  @shield_life, 1)
	  end
	end
  end
  

  ##Main
  def control(pool)
    control_update()
	#passive triggers
	case @status
	when :idling
	  @status = :running if combo?(:left, 150, :left) ||
	                        combo?(:right, 150, :right) ||
		                    combo?(:up, 150, :up) ||
							combo?(:down, 150, :down)
	  @status = :guarding if b? && @shield_life > 0
	when :running
	  @status = :idling if !right? && !left? && !down? && !up?
	  @status = :guarding if b? && @shield_life > 0
    when :guarding
	  @status = :idling unless b?
	end
	#active triggers
	case @status
	when :idling, :running
	  @status = :slashing if a?
	  @status = :thrusting if command?(front, a)
	when :guarding
	  @status = :knocking if a?
	end
	#actions
	case @status
	when :idling then walk()
	when :running then run()
	when :guarding then guard()
	when :slashing then slash(pool)
	when :thrusting then thrust(pool)
	when :knocking then knock(pool)	
	when :blocking then blockstun()
	when :tumbling then tumble()
	when :hurting then hurt()
	else raise "Unknown status #{@status}"
	end
  end
  
  
  ##States
  def walk()
	velocity.apply(movement_direction(2000 * delta))
	velocity.trim(100)
	if target
	  direction.angle = Vector.new(target.x - x, target.y - y).angle
    else
	  direction.angle = velocity.angle unless velocity.zero?
	end
	@image = velocity.zero? ? angled_graphic(:idle) : angled_graphic(:walk)
  end
  
  def guard()
    velocity.apply(movement_direction(2000 * delta))
	velocity.trim(70)
	if target
	  direction.angle = Vector.new(target.x - x, target.y - y).angle
    else
	  direction.angle = velocity.angle unless velocity.zero?
	end
	#@image = velocity.zero ? angled_graphic(:guard_i) : angled_graphic(:guard_w)
  end
  
  def run()
	velocity.apply(movement_direction(1500 * delta))
	velocity.trim(160)
	direction.angle = velocity.angle unless velocity.zero?
	@image = angled_graphic(:run)
  end
  
  
  ##Actions
  def slash(pool)
    regular_event(13, 2, 10) do |init|
	  if init
	    @event = Event.new(Rectangle.new(0, 0, 40, 25))
	  else
	    @event.in_front_of(self, 25)
		@event.collide(pool-[self]) do |entity|
		  if entity.status == :guarding
		    entity.status = :blocking
		    self.apply_force(-direction.with_norm(75))
			entity.apply_force(direction.with_norm(125))
			entity.shield_life -= 20
		  else
		    entity.apply_force(direction.with_norm(50))
		    entity.status = :hurting
		  end
		  @event = nil
	    end
	  end
	end
  end
  
  def thrust(pool)
    regular_event(15, 2, 15) do |init|
	  if init
	    @event = Event.new(Rectangle.new(0, 0, 10, 35))
	  else
	    @event.in_front_of(self, 30)
		@event.collide(pool-[self]) do |entity|
		  if entity.status == :guarding
		    entity.status = :blocking
			self.apply_force(-direction.with_norm(75))
		  	entity.apply_force(direction.with_norm(125))
			entity.shield_life -= 20
		  else
		    entity.apply_force(direction.with_norm(50))
		    entity.status = :hurting
		  end
		  @event = nil
	    end
	  end
	end
  end
  
  def knock(pool)
    regular_event(4, 6, 2) do |init|
	  if init
	    @event = Event.new(Rectangle.new(0, 0, 25, 20))
		velocity.reset()
		apply_force(direction.with_norm(100))
	  else
	    @event.in_front_of(self, 15)
		@event.collide(pool-[self]) do |entity|
		  entity.apply_force(direction.with_norm(125))
		  entity.status = :tumbling
		  @event = nil
	    end
	  end
	end
  end
  
  
  ##Specials
  def blockstun()
    wait(12)
  end
  
  def tumble()
    wait(14)
  end
  
  def hurt()
    ##
  end
end