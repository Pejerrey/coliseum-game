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
	
	@prev_push_time = nil
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
  
  def last_input?(key)
    return @command_list.size > 0 && @command_list.last[:keys].include?(key)
  end
  
  def command?(*keys)
    return keys.all?{ |key| @active_keys.include?(key) }
  end
  
  def combo?(*args) #CHANGE THIIIS
    index = @command_list.size - 1
    args.reverse_each do |x|
	  return false if index < 0
	  if x.is_a?(Symbol)
	    #map symbols
	    key = case x
		      when :left then left
		      when :right then right
		      when :up then up
		      when :down then down
		      end
		#check key
		return false unless @command_list[index][:keys].include?(key)
		if index == @command_list.size - 1
		  return false unless @active_keys.include?(key)
		end
	  elsif x.is_a?(Numeric)
	    #check time
		return false unless @command_list[index][:time] < x
		#next block
		index -= 1
	  else
	    raise "x es cualca"
	  end
	end
	return true
  end
  
  ##Loop
  def update()
    @active_keys = $window.active_keys & controlKeys
	@pushed_keys = $window.pushed_keys & controlKeys
	@released_keys = $window.released_keys & controlKeys
	unless @pushed_keys.empty?
	  @command_list << { :time => now() - (@prev_push_time || 0),
	                     :keys => @pushed_keys }
	  @prev_push_time = now()
	  @command_list.shift() while @command_list.size > 10
	end
  end
  
  
  ##Auxiliars
  private
  def controlKeys()
    [@down, @up, @left, @right, @a, @b, @c]
  end
  
  def now()
    Gosu.milliseconds() || 0
  end
end