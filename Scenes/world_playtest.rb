class WorldPlaytest < World
  include Constants
  
  def update()
    super()
    case @director
	when :intro_init
	  @object_pool << TestPlayer.new(:p_poly, Rectangle.new(250, 300, 40, 30),
	                                 Controller.new(W, S, A, D, G, H, J))
	  @object_pool << TestPlayer.new(:p_circ, Circle.new(400, 400, 50),
	                                 Controller.new(UP, DOWN, LEFT, RIGHT, N1, N2, N3))
	  @object_pool << Entity.new(:e_cave, Polygon.new(500, 100,
	                                      1,0, 2,-2, 2,-3, -2,-3, -4,0, -4,3, -2,0, -1,4, 3,2))
	  obj(:p_poly).apply_force(Vector.new(300, 16))
	  obj(:e_cave).scale(30)
	when :intro
	  #Things go here 
	
	else unknown_director()
	end
  end
end