class SceneIntro < Scene
  def initialize()
    super
  end
  
  def update()
    case @director
	when :intro
	  @director = :loading
	  
	when :loading
	  if @entry
	    @object_pool << StaticImage.new(:i_loading,
		                Gosu::Image.from_text("Loading", 20),
						$window.width - 100, $window.height - 50, 1) 
		@object_pool << StaticImage.new(:i_grin,
		                Gosu::Image.new("grin.png"),
						$window.width - 200,$window.height - 240, 0)
		@timer = Timer.new()
		@timer.start(1000)
		@entry = false
	  else
	    if @timer.done? #Stops itself
		  $window.add_scene(SceneMenu.new())
		  $window.remove_scene(self)
		end
	  end
	end
	
  end
  
  def draw()
    case @director
	when :intro
	
	when :loading
	  unless @entry
	    @object_pool.each { |image| image.draw() }
	  end
	end
	
  end
end