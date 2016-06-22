class Scene
  attr_accessor :visible, :director, :entry, :object_pool
  
  def initialize()
    @visible = true
	@next_director = :intro
	@director = :intro
	@entry = true
	@object_pool = []
  end
  
  def update()
    update_director()
    @object_pool.each do |object|
	  object.update() if object.respond_to?(:update)
	end
  end
  
  def draw()
    @object_pool.each do |object|
	  object.draw() if object.respond_to?(:draw)
	end
  end
  
  def obj(sym)
    obj = @object_pool.find{ |elem| elem.tag == sym }
	raise "Object not found #{sym}" unless obj
	return obj
  end
  
  def direct_to(name)
    @next_director = name
  end
  
  def update_director()
    @director = @next_director
  end
  
  def visible?()
    @visible
  end
end