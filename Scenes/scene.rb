class Scene
  attr_accessor :visible, :director, :init, :object_pool
  
  ##Initialization
  def initialize()
    @visible = true
	@next_director = :intro
	@director = nil
	@object_pool = []
  end
  
  ##Accessors
  def obj(sym)
    obj = @object_pool.find{ |elem| elem.tag == sym }
	raise "Object not found #{sym}" unless obj
	return obj
  end
  
  def direct_to(name)
    @next_director = name
  end
  
  def new_director?()
    @next_director != nil
  end
  
  def visible?
    @visible
  end
  
  ##Loop
  def update()
    init() if new_director?()
	update_objects()
  end
  
  def update_objects()
    @object_pool.each do |object|
	  object.update() if object.respond_to?(:update)
	end
  end
  
  def init()
    #This is horrible, but anyway...
	#The idea is executing update with an "init" director before the real deal
    temp_dir = @next_director
	@next_director = nil
	@director = :"#{temp_dir}_init"
	self.update()
	@director = temp_dir
  end
  
  def unknown_director()
    unless @director =~ /_init\z/
	  raise "Director #{@director} hasn't match with anything on #{self.class}"
	end
  end
  
  def draw()
    @object_pool.each do |object|
	  object.draw() if object.respond_to?(:draw)
	  object.debug_draw() if $DEBUG_MODE && object.respond_to?(:debug_draw)
	end
  end
end