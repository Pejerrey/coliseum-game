class Loop
  attr_accessor :tag, :image, :z, :flipped
  
  ##Constructor
  def initialize(tag, sequence_temp, z = 0)
    @tag = tag
	@sequence = []
	previous_time = 0
	sequence_temp.each_slice(2) do |pair|
	  @sequence << { :image => Gosu::Image.new("media/" + pair.first) ,
	                 :time => pair.last + previous_time }
	  previous_time = @sequence.last[:time]
	end
	@z = z
	@loop_start = now()
  end
  
  ##Accessors
  def width() 
    return @sequence[0][:image].width
  end
  
  def height()
    return @sequence[0][:image].height
  end
  
  def loop_size()
    return @sequence.last[:time]
  end
  
  ##Loop
  def draw(x, y)
    loop_time = (now() - @loop_start) % loop_size()
	draw_i = 0
	@sequence.each_with_index do |frame, i|
	  break if loop_time > frame[:time]
	  draw_i = i
	end
	@sequence[draw_i][:image].draw(x - width/2, y - height/2, @z)
  end
  
  ##Auxiliars
  private
  def now()
    Gosu.milliseconds() || 0
  end
end