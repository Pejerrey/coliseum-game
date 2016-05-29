class GameWindow < Gosu::Window
  attr_accessor :active_keys, :pushed_keys, :released_keys, :scenes
  
  def initialize(width, height, caption, fullscreen)
    super width, height, :fullscreen => fullscreen
    self.caption = caption
	@scenes = []
	@active_keys = []
	@pushed_keys = []
	@released_keys = []
	@log = Log.new(self)
  end

  
  #MAIN
  def update()
    @scenes.each do |scene|
	  scene.update()
    end
	@pushed_keys.clear
	@released_keys.clear
	if $DEBUG_MODE && Thread.list.size == 1
	  Thread.new do
	    #puts "Thread Started"
	    @log.log()
		#puts "Thread Finished"
	  end.run
	end
	
  end

  def draw()
    @scenes.each do |scene|
      scene.draw() if scene.visible 
	end
  end
  
  
  ##CALLBACKS
  def button_down(id)
    @active_keys << id
	@pushed_keys << id

	self.close if id == Gosu::KbEscape
  end
  
  def button_up(id)
    @active_keys.delete(id)
	@released_keys << id
  end
  
  
  #SCENES
  def add_scene(scene)
    @scenes << scene
  end
  
  def remove_scene(scene)
    @scenes.delete(scene)
  end
  
  
  #INPUT  
  def pushed?(key)
    @pushed_keys.include?(key)
  end
  
  def released?(key)
    @released_keys.include?(key)
  end
  
  def active?(key)
    @active_keys.include?(key)
  end
  
  def needs_cursor?()
    return true
  end

end