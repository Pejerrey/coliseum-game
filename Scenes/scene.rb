class Scene
  attr_accessor :visible, :director, :entry, :object_pool
  
  def initialize()
    @visible = true
	@director = :intro
	@entry = true
	@object_pool = []
  end
  
  def update()
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
  
  def visible?()
    @visible
  end
end