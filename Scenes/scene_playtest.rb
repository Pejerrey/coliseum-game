class ScenePlaytest < Scene
  def update()
    super()
    case @director
	when :intro_init
	  @object_pool << Button.new(:b_screen, Rectangle.new($window.width/2, $window.height/2, $window.width, $window.height))
	  @object_pool << Body.new(:r_poly, 100, Circle.new(0, 0, 100))
	  @object_pool << Body.new(:r_guy, 50, Rectangle.new(250, 300, 40, 30))
	when :intro
	  obj(:r_poly).x = $window.mouse_x
	  obj(:r_poly).y = $window.mouse_y
	  puts "INTERSECTS" if obj(:r_guy).collides?(obj(:r_poly))
	
	else unknown_director()
	end
  end
end