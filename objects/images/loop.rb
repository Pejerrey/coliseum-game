class Loop
  attr_accessor :tag, :image, :z, :x_scale, :y_scale, :loop_start
  
  ##Constructor
  def initialize(tag, sequence_temp, z = 0, x_scale = 1, y_scale = 1)
    @tag = tag
	@sequence = []
	previous_time = 0
	sequence_temp.each_slice(2) do |pair|
	  @sequence << { :image => Gosu::Image.new("media/" + pair.first) ,
	                 :time => pair.last + previous_time }
	  previous_time = @sequence.last[:time]
	end
	@z = z
	@x_scale = x_scale
	@y_scale = y_scale
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
  def draw(x, y, angle = 0)
    loop_time = (now() - @loop_start) % loop_size()
	@sequence.each_with_index do |frame, i|
	  if loop_time < frame[:time]
	    frame[:image].draw_rot(x, y, @z,
	                           angle, 0.5, 0.5,
					           @x_scale, @y_scale)
		return
	  end
	end
  end
  
  ##Auxiliars
  private
  def now()
    Gosu.milliseconds() || 0
  end
end