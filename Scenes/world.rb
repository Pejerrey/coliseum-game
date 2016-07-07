class World < Scene
  COLLISION_PRECISION = 1
  RESOLVE_TRIES = 10
  
  ##Loop
  def update()
    init() if new_director?()
	update_objects()
	#collision_resolve()
	inner_control(@object_pool)
  end
  
  
  ##Auxiliars
  def inner_control(entity_pool)
    @object_pool.each do |object| #World Triggers from Inner Object Behaviour
	  object.control(entity_pool) if object.class.included_modules.include?(Controllable)
	end
  end
end