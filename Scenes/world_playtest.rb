class WorldPlaytest < World
  include Constants
  
  def update()
    super()
    case @director
	when :intro_init
	  @object_pool << Picture.new(:sand, Still.new('sand.png'),
	                              $window.width/2, $window.height/2)
	  @object_pool << TestPlayer.new(:p_1, Circle.new($window.width/2-100, $window.height/2, 12),
	                                 Controller.new(W, S, A, D, G, H, J))
	  @object_pool << TestPlayer.new(:p_2, Circle.new($window.width/2+100, $window.height/2, 12),
	                                 Controller.new(UP, DOWN, LEFT, RIGHT, COMMA, PERIOD, SLASH))
	  @object_pool << StaticEntity.new(:e_field, InverseCircle.new($window.width/2, $window.height/2, 500))
	  obj(:p_1).target = obj(:p_2)
	  obj(:p_2).target = obj(:p_1)
	  @timer = Timer.new()
	  @timer.start(2000 + rand(2000))
	when :intro
	  #Reaction Test
	  if @timer && @timer.done?()
	     obj(:p_2).status = :thrusting
		 @timer = nil
	  end
	  #Reset
	  if $window.active_keys.include?(R)
	    @object_pool.clear()
	    direct_to(:intro) 
	  end
	    
	  
	else unknown_director()
	end
  end
end