class SceneIntro < Scene
  def update()
    super()	
    case @director
	when :intro_init
	  @object_pool << Picture.new(:i_loading,
		               Still.new(Gosu::Image.from_text("Loading", 20), 1),
		   			   $window.width - 100, $window.height - 50) 
	  @object_pool << Picture.new(:i_grin,
		               Still.new(Gosu::Image.new("grin.png"), 0),
					   $window.width - 200,$window.height - 240)
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