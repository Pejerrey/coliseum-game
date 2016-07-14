class Event
  include Corporeal
  include DebugDrawable
  
  attr_accessor :body
  def initialize(tag = :inner, body)
    @tag = tag
    @body = body
  end
  
  def collide(entity_pool)
	entity_pool.each do |entity|
	  if @body.collides?(entity.body)
	    yield(entity)
		return   ##Can I erase the event here?
	  end
	end
  end
end