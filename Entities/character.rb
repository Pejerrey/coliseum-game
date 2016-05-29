class Character < Entity
  
  ##Initialization 
  attr_accessor :control, :state
  attr_accessor :quickness, :top_walking, :top_running
  attr_accessor :Ldash_speed, :Ldash_hold, :Ldash_recovery
  attr_accessor :Hdash_speed, :Hdash_hold, :Hdash_recovery
  attr_accessor :event_timer
  attr_accessor :dash_angle
  
  def initialize(width, height, mass, x, y, angle, control)
    super(width, height, mass, :rectangle, nil, x, y, angle)
	@control = control
	@state = :idling
	@event_timer = Timer.new()
	#DEFAULT
	@quickness = 20 #Run acceleration
	@top_walking = 120 #Top walking speed
	@top_running = 250 #Top running speed
	@Ldash_speed = 400 #Initial dash speed
	@Ldash_hold = 100 #Time(ms) the speed is maintained
	@Ldash_recovery = 0 #Time after hold until you can move again
	@Hdash_speed = 700
	@Hdash_hold = 200
	@Hdash_recovery = 150
	@dash_angle = 0
  end
 
 
  ##Public Methods  
  def drag(floor)
    unless (control.any_move?() && @state == :idling) || @state == :running
	  super(floor)
    end
  end
  
  def input()
    control.update()
	
	
	
	#EVENTS
	#Loops
	if @state == :Ldashing
	  Ldash()
	  return
	end
	if @state == :Hdashing
	  Hdash()
	  return
	end
	#Triggers
	#Dash
	if control.a? && (not @state == :Ldashing) && (not @state == :Hdashing)
	  @state == :running ? Hdash() : Ldash()
	  puts "#{now} #{@state}"
	  return
	end
	
	
	
	#FLAGS
	#Run On
	unless @state == :running
	  if control.link?(control.down, 200, control.down) then @state = :running end
	  if control.link?(control.up, 200, control.up) then @state = :running end
	  if control.link?(control.left, 200, control.left) then @state = :running end
	  if control.link?(control.right, 200, control.right) then @state = :running end
	  if control.link?(control.a, 200, control.down) then @state = :running end
	  if control.link?(control.a, 200, control.up) then @state = :running end
	  if control.link?(control.a, 200, control.left) then @state = :running end
	  if control.link?(control.a, 200, control.right) then @state = :running end
	end
	#Run Off
	if @state == :running && (not control.any_move?) then @state = :idling end
	  
	  
	#ACTIONS
	#Moving
	if control.any_move?() 
	  @state == :running ? run() : walk()
	end
  end
  
  def draw()
    #@image.draw_rot(drawX, drawBottom, 2, 0, 0.5, 1.0, zoomx, 1.5)
	Utils.draw_rect(@x, @y, @width, @height, Gosu::Color::RED, 4) if $COLLISION_BOX
  end
  
  
  private
  ##Private Functions
  def now()
    Gosu.milliseconds()
  end
  
  def control_angle()
    if control.left?()
	  if    control.up?()   then return Utils.toRadians(135)
	  elsif control.down?() then return Utils.toRadians(225) 
	  else                       return Utils.toRadians(180)  end
	elsif control.right?()
	  if    control.up?()   then return Utils.toRadians(45) 
	  elsif control.down?() then return Utils.toRadians(315) 
	  else                       return Utils.toRadians(0)  end	   
	else
	  if    control.up?()   then return Utils.toRadians(90) 
	  elsif control.down?() then return Utils.toRadians(270)  end
	end
  raise "character.rb -> control_angle 'control_angle call with no buttons pressed'"
  end
  
  def pj_angle()
    Utils.angleVector(@speedx, @speedy)
  end
end