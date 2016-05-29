class Button
  include Constants
  
  #Constructor
  attr_accessor :active_area, :tag
  attr_accessor :mouse_pos, :ms_left_push, :ms_left_release, :pushing, :activated
  def initialize(tag, active_area)
	@tag = tag
	@active_area = active_area
	
	@pushing = false
	@activated = false
  end
  
  def draw()
    Utils.draw_rect(@active_area)
  end
  
  #Action
  def update()
    #Upload Input
	mouse_pos = Point.new($window.mouse_x, $window.mouse_y)
    if @pushing
	  unless Utils.inside_rect?(mouse_pos, @active_area)
	    @pushing = false
	  end
	  if $window.released?(MSLEFT)
	    @activated = true
      end
	else
	  if $window.pushed?(MSLEFT) && Utils.inside_rect?(mouse_pos, @active_area)
	    @pushing = true
	  end
	end
  end
  
end