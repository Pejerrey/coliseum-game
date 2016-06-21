class SceneMenu < Scene
  def initialize()
    super
  end
  
  def update()
    case @director
	when :intro
	  @director = :menu
	  
	when :menu
	  if @entry
	    @object_pool << StaticImage.new(:i_newgame,
		                 Gosu::Image.from_text("New Game", 30),
						 100, 100) 
		@object_pool << Button.new(:b_newgame, obj(:i_newgame).bounds)
	    @object_pool << StaticImage.new(:i_exit, 
		                 Gosu::Image.from_text("Exit", 30),
						 100, 150)
		@object_pool << Button.new(:b_exit, obj(:i_exit).bounds)
		@entry = false
	  else
		super()
		if (obj(:b_newgame).activated?)
		  $window.add_scene(ScenePlaytest.new())
		  $window.remove_scene(self)
		end
		if (obj(:b_exit).activated?)
		  $window.close()
		end
	  end
	end
	
  end
  
  def draw()
    case @director
	when :intro
	
	when :menu
	  super()
	end
	
  end
  
end