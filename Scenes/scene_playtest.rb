class ScenePlaytest < Scene
  def update()
    super()
    case @director
	when :intro_init
	  #@object_pool << Button.new(:b_screen, Rectangle.new($window.width/2, $window.height/2, $window.width, $window.height))
	  @object_pool << Entity.new(:r_guy, Circle.new(0, 0, 100))
	  @object_pool << Entity.new(:r_poly, Rectangle.new(250, 300, 40, 30))
	when :intro
	  obj(:r_guy).move_to($window.mouse_x, $window.mouse_y)
	  obj(:r_poly).advance(0.2, 0.2)
	  puts "INTERSECTS" if obj(:r_guy).collides?(obj(:r_poly))
	
	else unknown_director()
	end
  end
end