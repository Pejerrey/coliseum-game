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
  
  #Action
  def update()
    mouse_pos = { :x => $window.mouse_x, :y => $window.mouse_y}
    if @pushing
	  unless @active_area.holds?(mouse_pos)
	    @pushing = false
	  end
	  if $window.released?(MSLEFT)
	    @activated = true
      end
	else
	  if $window.pushed?(MSLEFT) && @active_area.holds?(mouse_pos)
	    @pushing = true
	  end
	end
  end
  
  def draw()
    @active_area.draw()
  end
  
  def activated?()
    @activated
  end
end