class ScenePlaytest < Scene
  def initialize()
    super
  end
  
  def update()
    case @director
	when :intro
	  @director = :loop
	  
	when :loop
	  if @entry
	    @object_pool << Body.new(:r_guy, 50, Circle.new(250, 300, 30))  
		@entry = false
	  else
	    obj(:r_guy).x += 5.5
		puts obj(:r_guy).right()
	  end
	  
	end
	
  end
  
  def draw()
    case @director
	when :intro
	
	when :loop
	  super()
	  
	end
	
  end
  
end