class Hitbox
  include Corporeal
  include DebugDrawable
  
  attr_accessor :body
  def initialize(body)
    @body = body
  end
  
  def collide(entity_pool, *exceptions)
	entity_pool.each do |entity|
	  next if exceptions.include?(entity)
	  if @body.collides?(entity.body)
	    yield(entity)
		return
	  end
	end
  end
end