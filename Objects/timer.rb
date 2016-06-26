class Timer
  ##Public Methods
  attr_accessor :tag
  def initialize(tag)
    @tag = tag
    @start_point = -1
	@end_point = -1
  end
  
  def start(duration = -1)
    @start_point = now() #ms
	@end_point = duration != -1 ? now() + duration : -1
  end
  
  def stop()
    @start_point = -1
	@end_point = -1
  end
  
  def running?()
    @start_point >= 0
  end
  
  def elapsed()
    raise "timer.rb -> call to elapsed() with clock stopped" if @start_point == -1
    now() - @start_point
  end
  
  def done?() #Takes care of stoping the timer
    raise "timer.rb -> call to done?() with end_point == -1" if @end_point == -1
    if now() >= @end_point
	  self.stop()
	  return true
	else
	  return false
	end
  end
  
  def excess()
    raise "timer.rb -> call to excess() with end_point == -1" if @end_point == -1
    now() - @end_point
  end
  

  private
  ##Private Methods
  def now()
    Gosu.milliseconds() || 0
  end
end