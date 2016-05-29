class HumanControl
  ##Initialization
  attr_accessor :up, :down, :left, :right, :a, :b, :c, :active_keys, :last_input, :move_input_order_h, :move_input_order_v, :combos, :mode, :comboTimer
  
  def initialize(up, down, left, right, a, b, c)
    @up = up
	@down = down
	@left = left
	@right = right
	@a = a
	@b = b
	@c = c
	
	@active_keys = []
	@last_input = [] #Link Input + New Input   #Input in the last cycle
	@combos = []	
	@move_input_order_h = []
	@move_input_order_v = []
	
	@mode = 1 #0.Deactivated 1.Game
	@comboTimer = Timer.new()
  end
  
  
  
  ##Public Methods
  def update()
    @comboTimer.start() if @last_input.empty? 
	unless (controlKeys & $window.input).empty? #Cycles through every "input" pressed in the last cycle
	  refreshLastInput() #Stores said input in +last_input+
	  updateCombos()
      updateStrokeOrder() #Stores stroke priority to deal with conflicting active keys
	  cleanLastInput() #Clean +last_input+, except for the last item (???, for comboes?)
	  cleanCombos() #No more than 6 links are processed
	end
	updateActiveKeys()
  end
  
  def flushCombos()
    @combos = []
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
  
  def any_move?
    up? || down? || left? || right?
  end
  
  def link?(key1, limit, key2)
    return if @combos.empty?
    last_link = @combos.last
	if key1 == last_link[0] && last_link[1] < limit && key2 == last_link[2]
	  return true
	else
	  return false
	end
  end
  
  def messyLink?(key1, limit, key2)
    link?(key1, limit, key2) || link?(key2, limit, key1)
  end
  
  
  
  
  ##Private Methods
  private
  def refreshLastInput()
    @last_input.concat(controlKeys & $window.input)
  end
  
  def cleanLastInput()
    @last_input = [@last_input.last()]
  end
  
  def updateCombos()
	(0...@last_input.size - 1).each_with_index do |input, i|
	  @combos << [@last_input[i], @comboTimer.runtime, @last_input[i + 1]]
	  @comboTimer.start()
	end
  end
  
  def cleanCombos()
    if @combos.size > 6 then
	  @combos.shift()
	end
  end
  
  def updateStrokeOrder()
    @last_input.each do |input|
      if [@left, @right].include?(input)
	    @move_input_order_h.delete(input)
	    @move_input_order_h << input
	  elsif [@up, @down].include?(input)
	  	@move_input_order_v.delete(input)
	    @move_input_order_v << input
	  end
	end
  end
  
  def updateActiveKeys()
    #1. Get Pressed Buttons 
	@active_keys = controlKeys & $window.active_keys
	#2. Resolve Key Conflicts (Eg. Left, Right)
	store = nil
	delete = []
	@move_input_order_h.each do |stroke|
	  @active_keys.each do |key|
	    if stroke == key
		  delete << store unless store == nil   ##Shouldn't be "key", instead of "store"?
		  store = key
		end
	  end
	end
	store = nil
	@move_input_order_v.each do |stroke|
	  @active_keys.each do |key|
	    if stroke == key
		  delete << store unless store == nil
		  store = key
		end
	  end
	end
	@active_keys.delete_if { |key| delete.include?(key) }
  end
  
  def controlKeys()
    [@down, @up, @left, @right, @a, @b, @c]
  end
end