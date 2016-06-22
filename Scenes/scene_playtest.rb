class ScenePlaytest < Scene
  def initialize()
    super
  end
  
  
  def update()
    super()
    case @director
	when :intro
	  @object_pool << Button.new(:b_screen, Rectangle.new($window.width/2, $window.height/2, $window.width, $window.height))
	  @object_pool << Body.new(:r_guy, 50, Circle.new(250, 300, 30))  
	  direct_to(:neutral)
	  
	when :neutral
	  if (obj(:b_screen).activated?)
		direct_to(:holding)
		@point_a = { :x => $window.mouse_x, :y => $window.mouse_y }
	  end
	
	when :holding
	  @segment = Segment.new(@point_a[:x], @point_a[:y], $window.mouse_x, $window.mouse_y)
	  direct_to(:neutral) if obj(:b_screen).activated?
	  puts "CUTS" if obj(:r_guy).intersects?(@segment)
	
	end
  end
  
  
  def draw()
    case @director
	when :intro
	  super()
	
	when :neutral
	  super()
	  
	when :holding
	  super()
	  
	end
  end
  
  
end