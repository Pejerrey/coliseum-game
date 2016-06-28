class PlayerController
  ##Initialization
  attr_accessor :up, :down, :left, :right, :a, :b, :c
  attr_accessor :active_keys, :last_input, :move_input_order_h, :move_input_order_v
  attr_accessor :combos, :mode, :comboTimer
  
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
	
	@last_input = [] #Link Input + New Input   #Input in the last cycle
	@combos = []	
	@move_input_order_h = []
	@move_input_order_v = []
	
	@mode = 1 #0.Deactivated 1.Game
	@comboTimer = Timer.new()
  end
  
  
  
  ##Public Methods
  def update()
    upload()
  end
  
  def upload()
    @active_keys = $window.active_keys & controlKeys
	@pushed = $window.pushed_keys & controlKeys
	@released = $window.released_keys & controlKeys
  end
  
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
    @active_keys.include?(@b)
  end
  
  
  ##Private Methods
  private
  
  def controlKeys()
    [@down, @up, @left, @right, @a, @b, @c]
  end
end