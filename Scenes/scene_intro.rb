class SceneIntro < Scene
  def update()
    super()	
    case @director
	when :intro_init
	  @object_pool[:i_loading] =
	    Picture.new(Text.new("Loading", 20, 1),
		            $window.width - 100, $window.height - 50)
	  @object_pool[:i_grin] = 
	    Picture.new(Still.new("grin.png"),
					$window.width - 200, $window.height - 240)
	  @object_pool[:t_load] =
	    Timer.new()
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