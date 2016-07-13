class Pacemaker
  LAG_THRESHOLD = 67   #ms
  
  attr_accessor :pace
  
  ##Constructor
  def initialize(pace = 1)
    @pace = 1
  end
  
  ##Accesors
  def elapsed()
    @elapsed * @pace
  end
  
  def elapsed_ms()
    @elapsed_ms * @pace
  end
  
  ##Loop
  def beat()
    interval = now() - (@before || 0)
	if interval > LAG_THRESHOLD
	  @elapsed_ms = 0
	  @elapsed = 0 #Lag Freeze
	else
	  @elapsed_ms = interval
	  @elapsed = interval / 1000.0
	end
	@before = now()
  end
  
  ##Auxiliars
  private
  def now()
    Gosu.milliseconds() || 0
  end
end