class GameWindow < Gosu::Window
  attr_accessor :active_keys, :pushed_keys, :released_keys
  attr_accessor :scenes
  attr_accessor :pacemaker
  attr_accessor :log
  
  ##Constructor
  def initialize(width, height, caption, fullscreen)
    super(width, height, :fullscreen => fullscreen)
    self.caption = caption
	@scenes = []
	@active_keys = []
	@pushed_keys = []
	@released_keys = []
	@pacemaker = Pacemaker.new()
	@log = nil
  end

  
  ##Accessors  
  #Scenes
  def add_scene(scene)
    @scenes << scene
  end
  
  def remove_scene(scene)
    @scenes.delete(scene)
  end
  
  #Input
  def pushed?(key)
    @pushed_keys.include?(key)
  end
  
  def released?(key)
    @released_keys.include?(key)
  end
  
  def active?(key)
    @active_keys.include?(key)
  end
  
  #Pacemaker
  def elapsed()
    @pacemaker.elapsed()
  end
  
  def elapsed_ms()
    @pacemaker.elapsed_ms()
  end
  
  def pace=(pace)
    @pacemaker.pace = pace
  end
  
  
  ##Loop
  def update()
    @pacemaker.beat()
    @scenes.each do |scene|
	  scene.update()
    end
	@pushed_keys.clear
	@released_keys.clear
	if $DEBUG_MODE
	  $window.caption = Gosu::fps
	  if Thread.list.size == 1
	    Thread.new do
	      @log.log()
	    end.run
	  end
	end
  end

  def draw()
    @scenes.each do |scene|
      scene.draw() if scene.visible?()
	end
  end
  
  
  ##Callbacks
  def button_down(id)
    @active_keys << id
	@pushed_keys << id
  end
  
  def button_up(id)
    @active_keys.delete(id)
	@released_keys << id
  end
  
  def needs_cursor?()
    return true
  end
end