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
    if @pushing
	  unless body.holds?($window.mouse_x, $window.mouse_y)
	    @pushing = false
	  end
	  if $window.released?(MSLEFT)
	    @activated = true
      end
	else
	  if $window.pushed?(MSLEFT) && body.holds?($window.mouse_x, $window.mouse_y)
	    @pushing = true
	  end
	end
  end
end