class Pacemaker
  #Constants
  LAG_THRESHOLD = 10 #FPS
  
  attr_accessor :pace
  def initialize(pace = 1)
    @pace = 1
  end
  
  ##Accesors
  def elapsed()
    @elapsed * @pace
  end
  
  ##Loop
  def beat()
    interval = now() - (@before || 0)
	if Gosu::fps <= LAG_THRESHOLD
	  @elapsed = 0 #Lag Freeze
	else
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