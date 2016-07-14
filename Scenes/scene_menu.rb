class SceneMenu < Scene
  def update()
    super()
    case @director
	when :intro_init
	  @object_pool << IButton.new(:b_newgame,
	                   Text.new("New Game", 30),  100, 100)
	  @object_pool << IButton.new(:b_exit, 
		               Text.new("Exit", 30),  100, 150)
	when :intro
	  if (obj(:b_newgame).activated?)
		$window.add_scene(WorldPlaytest.new())
		$window.remove_scene(self)
	  end
	  if (obj(:b_exit).activated?)
		$window.close()
	  end
	
	else unknown_director()
	end
  end
end