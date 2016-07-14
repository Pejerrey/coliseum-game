class WorldPlaytest < World
  include Constants
  
  def update()
    super()
    case @director
	when :intro_init
	  @object_pool << TestPlayer.new(:p_1, Circle.new(200, $window.height/2, 25),
	                                 Controller.new(W, S, A, D, G, H, J))
	  @object_pool << TestPlayer.new(:p_2, Circle.new(400, $window.height/2, 25),
	                                 Controller.new(UP, DOWN, LEFT, RIGHT, N1, N2, N3))
	  @object_pool << StaticEntity.new(:e_field, InverseCircle.new($window.width/2, $window.height/2, 500))
	when :intro
	  #Things go here 
	
	else unknown_director()
	end
  end
end