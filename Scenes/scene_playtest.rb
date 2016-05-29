class ScenePlaytest < Scene
  def initialize()
    super
  end
  
  def update()
    case @director
	when :intro
	  @director = :loop
	  
	when :loop
	  #Things go here
	  #Update Controllers
	  #
	  
	end
	
  end
  
  def draw()
    case @director
	when :intro
	
	when :loop
	  #Pictures go here
	  
	end
	
  end
  
end