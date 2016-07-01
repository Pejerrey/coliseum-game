class World < Scene
  ##Loop
  def update()
    init() if new_director?()
	pre_update_objects()
	update_objects()
	post_update_objects()
  end
  
  def pre_update_objects()
    @object_pool.each do |object|
	  object.pre_update() if object.respond_to?(:pre_update)
	end
  end
  
  def post_update_objects()
    @object_pool.each do |object|
	  object.post_update() if object.respond_to?(:post_update)
	end
  end
end