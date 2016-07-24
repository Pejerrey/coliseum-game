class World < Scene
  COLLISION_PRECISION = 1
  RESOLVE_TRIES = 10
  
  ##Loop
  def update()
    init() if @next_director
	update_objects()
	#collision_resolve()
	inner_control()
  end
  
  
  ##Auxiliars
  private
  def inner_control()
    puppet_pool = @object_pool.select{ |o| o.is_a?(Controllable) }
    entity_pool = @object_pool.select{ |o| o.is_a?(Physical) }
    puppet_pool.each do |puppet| #World Triggers from Inner Object Behaviour
	  puppet.control(entity_pool)
	end
  end
end