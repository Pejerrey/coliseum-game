class SceneIntro < Scene
  def update()
    super()	
    case @director
	when :intro_init
	  @object_pool << Image.new(:i_loading,
		               Gosu::Image.from_text("Loading", 20),
		   			   $window.width - 100, $window.height - 50, 1) 
	  @object_pool << Image.new(:i_grin,
		               Gosu::Image.new("grin.png"),
					   $window.width - 200,$window.height - 240, 0)
	  @object_pool << Timer.new(:t_load)
	  obj(:t_load).start(1000)
	when :intro
	  if obj(:t_load).done?
	    obj(:t_load).stop()
		$window.add_scene(SceneMenu.new())
		$window.remove_scene(self)
	  end
	  
	else unknown_director()
	end
  end
end