class World < Scene
  COLLISION_PRECISION = 1
  RESOLVE_TRIES = 10
  
  ##Loop
  def update()
    init() if new_director?()
	entity_pool = @object_pool.select{ |o| o.class.included_modules.include?(Physical) }
	normal_pool = @object_pool - entity_pool
	update_list(normal_pool)
	update_entities(entity_pool)
	inner_control()
  end
  
  
  ##Collision Manager
  #Supposed two bodies only
  def collision?(entity_pool)
    if entity_pool.length > 1
	  (0...(entity_pool.length-1)).each do |i|
	    (i+1...entity_pool.length).each do |j|
		  return true if entity_pool[i].collides?(entity_pool[j])
		end
	  end
	end
	return false
  end
  
  def update_entities(entity_pool)
  #Initialize
	try_pool = entity_pool.map { |e| Entity.new(e.tag, e.body.dup, e.velocity.dup) }
	##################################DIRECTIONDUP
	time_left = $window.elapsed
	tries = 0
	#Prob the first step
	update_list(try_pool, time_left)
	while collision?(try_pool) &&
	      tries <= RESOLVE_TRIES
	  #Find an approximate time of collision
	  time_prior = time_collision_aprox(entity_pool, time_left)
	  time_left -= time_prior
	  #Update movement prior the collision
	  update_list(entity_pool, time_prior)
	  raise "Collision when it shouldn't after time aprox" if collision?(entity_pool)
	  #Exchange of forces (Pritty hard)
	  force_exchange(entity_pool, try_pool)
	  #Prob the next step
	  copy_entity_list(entity_pool, try_pool)
	  update_list(try_pool, time_left)
	  tries += 1
	end
    #If a try_pool succeds an update without collision, entity_pool is
	#updated regularly for the remaining time
	update_list(entity_pool, time_left)
  end
  
  #Supposes normal
  def force_exchange(entity_pool, try_pool)
	(0...(entity_pool.length-1)).each do |i|
	  (i+1...entity_pool.length).each do |j|
	    if try_pool[i].collides?(try_pool[j])
		  entity_pool[i].velocity.x = 0
		  entity_pool[i].velocity.y = 0
		  entity_pool[j].velocity.x = 0
		  entity_pool[j].velocity.y = 0
		end
	  end
	end
  end
  
  def time_collision_aprox(entity_pool, time_left) #Right open search
    temp_pool = entity_pool.map { |e| Entity.new(e.tag, e.body.dup, e.velocity.dup) }
	s, i = 1.0, 0.0
	COLLISION_PRECISION.times do
	  m = (s+i)/2.0
	  update_list(temp_pool, time_left * m)
	  if collision?(temp_pool)
	    s = m
	  else
	    i = m
	  end
	  copy_entity_list(entity_pool, temp_pool)
	end  
	return time_left * i
  end
  
  
  ##Auxiliars
  def update_list(list, delta = nil)
    if delta
	  list.each { |e| e.update(delta) }
	else
	  list.each { |e| e.update() }
	end
  end
  
  def copy_entity_list(lin, lout) #tag and shape static
    (0...lin.size).each do |i|
	  lout[i].body.x = lin[i].body.x
	  lout[i].body.y = lin[i].body.y
	  #lout[i].body.direction.x = lin[i].body.direction.x
	  #lout[i].body.direction.y = lin[i].body.direction.y
	  lout[i].velocity.x = lin[i].velocity.x
	  lout[i].velocity.y = lin[i].velocity.y
    end
  end
  
  def inner_control()
    @object_pool.each do |object| #World Triggers from Inner Object Behaviour
	  object.control(@object_pool) if object.class.included_modules.include?(Controllable)
	end
  end
end