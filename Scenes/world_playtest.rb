class WorldPlaytest < World
  include Constants
  
  def update()
    super()
    case @director
	when :intro_init
	  @object_pool << TestPlayer.new(:p_1, Circle.new(300, $window.height/2, 12),
	                                 Controller.new(W, S, A, D, G, H, J))
	  @object_pool << TestPlayer.new(:p_2, Circle.new(400, $window.height/2, 12),
	                                 Controller.new(UP, DOWN, LEFT, RIGHT, N1, N2, N3))
	  @object_pool << StaticEntity.new(:e_field, InverseCircle.new($window.width/2, $window.height/2, 500))
	  obj(:p_1).target = obj(:p_2)
	  obj(:p_2).target = obj(:p_1)
	  @timer = Timer.new()
	  @timer.start(2000 + rand(2000))
	when :intro
	  #Temp Debug Draw
	  if obj(:p_1).status == :idling
	    obj(:p_1).c = YELLOW
	  elsif obj(:p_1).status == :slashing || obj(:p_1).status == :thrusting
	    obj(:p_1).c = GREEN
	  elsif obj(:p_1).status == :hurting
	    obj(:p_2).c = RED
	  elsif obj(:p_1).status == :guarding
	    obj(:p_1).c = GRAY
	  end
	  if obj(:p_2).status == :idling
	    obj(:p_2).c = YELLOW
	  elsif obj(:p_2).status == :slashing || obj(:p_2).status == :thrusting
	    obj(:p_2).c = GREEN
	  elsif obj(:p_1).status == :hurting
	    obj(:p_2).c = RED
	  elsif obj(:p_2).status == :guarding
	    obj(:p_2).c = GRAY
	  end
	  
	  #Reaction Test
	  if @timer && @timer.done?()
	     obj(:p_2).status = :thrusting
		 @timer = nil
	  end
	  
	else unknown_director()
	end
  end
end