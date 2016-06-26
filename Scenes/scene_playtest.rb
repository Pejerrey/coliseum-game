class ScenePlaytest < Scene
  def update()
    super()
    case @director
	# when :neutral
	  # if (obj(:b_screen).activated?)
		# direct_to(:holding)
		# @point_a = { :x => $window.mouse_x, :y => $window.mouse_y }
	  # end
	
	# when :holding
	  # @segment = Segment.new(@point_a[:x], @point_a[:y], $window.mouse_x, $window.mouse_y)
	  # direct_to(:neutral) if obj(:b_screen).activated?
	  
	when :intro_init
	  @object_pool << Button.new(:b_screen, Rectangle.new($window.width/2, $window.height/2, $window.width, $window.height))
	  @object_pool << Body.new(:r_poly, 100, Rectangle.new(0, 0, 100, 150))
	  @object_pool << Body.new(:r_guy, 50, Rectangle.new(250, 300, 40, 30))
	when :intro
	  obj(:r_poly).x = $window.mouse_x
	  obj(:r_poly).y = $window.mouse_y
	  puts "INTERSECTS" if obj(:r_guy).collides?(obj(:r_poly))
	
	end
  end
end