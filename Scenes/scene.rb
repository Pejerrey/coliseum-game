class Scene
  attr_accessor :visible, :director, :next_director, :object_pool
  
  ##Constructor
  def initialize()
    @visible = true
	@next_director = :intro
	@director = nil
	@object_pool = Hash.new()
  end
  
  
  ##Accessors
  def obj(sym)
    obj = object_pool[sym]
	raise "Object #{sym} not found" unless obj
	return obj
  end
  
  def direct_to(name)
    @next_director = name
  end
  
  def visible?()
    @visible
  end
  
  
  ##Loop
  def update()
    init() if @next_director
	update_objects()
  end
  
  def draw()
    @object_pool.each do |key, object|
	  object.draw() if object.is_a?(Drawable)
	  object.debug_draw() if $DEBUG_MODE && object.is_a?(DebugDrawable)
	end
  end
  
  
  ##Auxiliars
  private
  def update_objects()
    @object_pool.each do |key, object|
	  object.update() if object.respond_to?(:update)
	end
  end
  
  def init()
    #This is horrible, but anyway...
	#The idea is executing update with an "init" director before the real deal
    new_dir = @next_director
	@next_director = nil
	@director = :"#{new_dir}_init"
	self.update()
	@director = new_dir
  end
  
  def unknown_director()
    unless @director =~ /_init\z/
	  raise "Director #{@director} hasn't match with anything on #{self.class}"
	end
  end
end