class Controller
  attr_accessor :up, :down, :left, :right, :a, :b, :c
  attr_accessor :active_keys, :pushed_keys, :released_keys, :command_list
  
  ##Constructor
  def initialize(up, down, left, right, a, b, c)
    @up = up
	@down = down
	@left = left
	@right = right
	@a = a
	@b = b
	@c = c
	
	@active_keys = []
	@pushed_keys = []
	@released_keys = []
	@command_list = []
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
  
  
  ##Loop
  def update()
    @active_keys = $window.active_keys & controlKeys
	@pushed_keys = $window.pushed_keys & controlKeys
	@released_keys = $window.released_keys & controlKeys
	@command_list << @pushed_keys unless @pushed_keys.empty?
	@command_list.shift while @command_list.size > 10
  end
  
  
  ##Auxiliars
  private
  def controlKeys()
    [@down, @up, @left, @right, @a, @b, @c]
  end
end