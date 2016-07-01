module Clickable
  #Needs: body
  include Constants
  
  #Object Behaviour
  def activated?()
    if @activated
	  @activated = false
	  return true
	else
	  return false
	end
  end
  
  #Auxiliar State
  private
  def check_activation()
    mouse_pos = { :x => $window.mouse_x, :y => $window.mouse_y }
    if @pushing
	  unless body.holds?(mouse_pos)
	    @pushing = false
	  end
	  if $window.released?(MSLEFT)
	    @activated = true
      end
	else
	  if $window.pushed?(MSLEFT) && body.holds?(mouse_pos)
	    @pushing = true
	  end
	end
  end
end