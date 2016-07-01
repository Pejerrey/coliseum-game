class Controller
  ##Initialization
  attr_accessor :up, :down, :left, :right, :a, :b, :c
  attr_accessor :active_keys, :pushed, :released, :command_list
  attr_accessor :mode
  
  def initialize(up, down, left, right, a, b, c)
    @up = up
	@down = down
	@left = left
	@right = right
	@a = a
	@b = b
	@c = c
	
	@active_keys = []
	@pushed = []
	@released = []
	@command_list = []
	
	@mode = 1 #0.Deactivated 1.Game
  end
  
  
  ##Loop
  def update()
    #Upload
    @active_keys = $window.active_keys & controlKeys
	@pushed = $window.pushed_keys & controlKeys
	@released = $window.released_keys & controlKeys
	@command_list << @pushed unless @pushed.empty?
	@command_list.shift if @command_list.size > 10
  end
  
  
  ##Accessors
  def up?
    @active_keys.include?(@up)
  end
  
  def down?
    @active_keys.include?(@down)
  end
  
  def left?
    @active_keys.include?(@left)
  end
  
  def right?
    @active_keys.include?(@right)
  end
  
  def a?
    @active_keys.include?(@a)
  end
  
  def b?
    @active_keys.include?(@b)
  end
  
  def c?
    @active_keys.include?(@c)
  end
  
  
  ##Auxiliars
  private
  def controlKeys()
    [@down, @up, @left, @right, @a, @b, @c]
  end
end