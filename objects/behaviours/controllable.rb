module Controllable
  #Accessors  
  def up
    controller.up
  end
  
  def down
    controller.down
  end
  
  def left
    controller.left
  end
  
  def right
    controller.right
  end
  
  def a
    controller.a
  end
  
  def b
    controller.b
  end
  
  def c
    controller.c
  end
  
  def front
    return case body.direction.angle
	       when 45...135 then right
	       when 135...225 then down
		   when 225...315 then left
		   when 315..360, 0...45 then up
	       end
  end
  
  def back
    return case front
	       when up then down
		   when down then up
		   when left then right
		   when right then left
		   end
  end
  
  def up?
    controller.active_keys.include?(up)
  end
  
  def down?
    controller.active_keys.include?(down)
  end
  
  def left?
    controller.active_keys.include?(left)
  end
  
  def right?
    controller.active_keys.include?(right)
  end
  
  def arrow?
    up? || left? || right? || down?
  end
  
  def a?
    controller.active_keys.include?(a)
  end
  
  def b?
    controller.active_keys.include?(b)
  end
  
  def c?
    controller.active_keys.include?(c)
  end
  
  def front?
    controller.active_keys.include?(front)
  end
  
  def back?
    controller.active_keys.include?(back)
  end
  
  def active_keys()
    controller.active_keys()
  end
  
  def pushed_keys()
    controller.pushed_keys()
  end
  
  def released_keys()
    controller.released_keys()
  end
  
  def command_list()
    controller.command_list()
  end
    
  def last_input?(key)
    controller.last_input?(key)
  end
  
  def command?(*keys)
    controller.command?(*keys)
  end
  
  def combo?(*args)
    controller.combo?(*args)
  end
  
  ##Loop
  def control(pool)
    #This should actually be implemented in the class itself
	#I hope I'm not fucking everything up with this declaration
	#Ideally, it'll prevent "Controllable" classes from crashing
	#without a "control" method (Maybe they're meant to be
	#controlled in the main loop), but it'll still allow itself to
	#be overriden by classes who actually have inner control.
  end
  
  def control_update()
    controller.update()
  end
end